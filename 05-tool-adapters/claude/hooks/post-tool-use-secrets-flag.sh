#!/usr/bin/env bash
# .claude/hooks/post-tool-use-secrets-flag.sh
#
# PostToolUse hook: scan tool output for patterns that look like leaked
# secrets. Print a warning to stdout if a match is found. Does not block
# or redact.
#
# Input on stdin: JSON with .tool_name, .tool_input, .tool_response.
# Exit 0 to allow the agent to continue.
#
# Shipped in the AI-Native Engineering Harness as a copy-able example.
# The execute bit is not set in the harness; chmod +x after copying into
# your project's .claude/hooks/.

set -euo pipefail

# Read the hook input as JSON.
input="$(cat)"

# Extract the tool response text. The exact path may vary by Claude Code
# version; .tool_response.content is the common location at the time
# this hook was written.
output="$(echo "$input" | jq -r '.tool_response.content // .tool_response // ""')"

# If extraction returned nothing, Claude Code's hook input schema may
# have shifted. Fail loud, not closed: warn, surface the observed
# top-level keys, and fall back to scanning the raw input. False
# positives beat silent zero-coverage on a security tool.
if [ -z "$output" ]; then
  echo "WARNING: secrets-flag hook found no .tool_response content."
  echo "  Claude Code's hook input schema may have shifted; falling back to raw input."
  keys="$(echo "$input" | jq -r 'keys | join(", ")' 2>/dev/null || echo '<unparseable>')"
  echo "  top-level keys observed: ${keys}"
  output="$input"
fi

# Patterns to flag. Each is an extended regex (`grep -E`).
#
# Known false-positive surface — tune the patterns or narrow the
# matcher in settings.json if these dominate your tool output:
#   - Documentation pages with example tokens shaped like real ones
#     (e.g. `sk-AAAA...`, `ghp_AAAA...` in SDK READMEs).
#   - Test fixtures and snapshot tests with long opaque strings.
#   - Long placeholder values after generic keywords
#     (e.g. `password = "verylongplaceholdertext..."`).
patterns=(
  'AKIA[0-9A-Z]{16}'                                          # AWS access key
  'sk-[A-Za-z0-9]{20,}'                                       # OpenAI / Anthropic-style API key
  'ghp_[A-Za-z0-9]{36,}'                                      # GitHub personal access token
  'Bearer [A-Za-z0-9._-]{20,}'                                # bearer token in Authorization header
  '(api[_-]?key|secret|token|password)[^A-Za-z0-9]{1,3}[A-Za-z0-9._-]{16,}'  # generic key=value
)

# Lines that contain any of these markers are treated as obvious
# placeholders or fixtures and dropped from the flag set. Adjust to fit
# your codebase's conventions.
placeholder_markers='YOUR_|EXAMPLE_|REPLACE_|FIXME|TODO|placeholder|XXXXXXXXXXXX'

flagged=()
for pattern in "${patterns[@]}"; do
  if echo "$output" | grep -E "$pattern" | grep -E -v "$placeholder_markers" | grep -q .; then
    flagged+=("$pattern")
  fi
done

if [ ${#flagged[@]} -gt 0 ]; then
  echo "WARNING: PostToolUse hook matched secret-like pattern(s):"
  for p in "${flagged[@]}"; do
    echo "  - $p"
  done
  echo "Review the output before continuing. Rotate any real secret that has appeared here."
fi

# Always exit 0 — this hook flags, it does not block.
exit 0

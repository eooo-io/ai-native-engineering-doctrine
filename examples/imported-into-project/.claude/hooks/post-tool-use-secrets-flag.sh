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
# Copied from the harness adapter at
# 05-tool-adapters/claude/hooks/post-tool-use-secrets-flag.sh.
# The execute bit is not set in the harness; chmod +x after copying.

set -euo pipefail

# Read the hook input as JSON.
input="$(cat)"

# Extract the tool response text.
output="$(echo "$input" | jq -r '.tool_response.content // .tool_response // ""')"

# If extraction returned nothing, Claude Code's hook input schema may
# have shifted. Fail loud, not closed: warn, surface the observed
# top-level keys, and fall back to scanning the raw input.
if [ -z "$output" ]; then
  echo "WARNING: secrets-flag hook found no .tool_response content."
  echo "  Claude Code's hook input schema may have shifted; falling back to raw input."
  keys="$(echo "$input" | jq -r 'keys | join(", ")' 2>/dev/null || echo '<unparseable>')"
  echo "  top-level keys observed: ${keys}"
  output="$input"
fi

# Patterns to flag. Tune for your project's risk profile.
# Known false-positive surface: documentation example tokens, long
# placeholder values, and snapshot fixtures.
patterns=(
  'AKIA[0-9A-Z]{16}'                                          # AWS access key
  'sk-[A-Za-z0-9]{20,}'                                       # OpenAI / Anthropic-style API key
  'ghp_[A-Za-z0-9]{36,}'                                      # GitHub personal access token
  'Bearer [A-Za-z0-9._-]{20,}'                                # bearer token
  '(api[_-]?key|secret|token|password)[^A-Za-z0-9]{1,3}[A-Za-z0-9._-]{16,}'  # generic key=value
)

# Lines containing these markers are treated as placeholders and
# dropped from the flag set.
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

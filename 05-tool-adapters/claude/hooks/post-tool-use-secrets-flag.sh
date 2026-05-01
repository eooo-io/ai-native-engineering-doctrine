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
# version; .tool_response.content is the common location.
output="$(echo "$input" | jq -r '.tool_response.content // .tool_response // ""')"

# Patterns to flag. Tune these for your project's risk profile.
# Each pattern is an extended regex (`grep -E`).
patterns=(
  'AKIA[0-9A-Z]{16}'                                          # AWS access key
  'sk-[A-Za-z0-9]{20,}'                                       # OpenAI / Anthropic-style API key
  'ghp_[A-Za-z0-9]{36,}'                                      # GitHub personal access token
  'Bearer [A-Za-z0-9._-]{20,}'                                # bearer token in Authorization header
  '(api[_-]?key|secret|token|password)[^A-Za-z0-9]{1,3}[A-Za-z0-9._-]{16,}'  # generic key=value
)

flagged=()
for pattern in "${patterns[@]}"; do
  if echo "$output" | grep -E -q "$pattern"; then
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

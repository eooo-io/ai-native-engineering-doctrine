# Example: PostToolUse — flag potential secrets in tool output

A defensive hook that scans the output of every tool call for patterns that look like leaked credentials and surfaces a warning. It does not redact, block, or modify output — it flags.

## What it does

After Claude runs any tool, this hook reads the tool's output, scans for common secret patterns (API keys, tokens, bearer headers), and prints a warning to stdout if anything matches. Claude reads stdout as additional context for the next turn — the warning becomes visible to both the user and the agent. A real human (or the agent) decides what to do.

This is a low-friction safety net layered on top of the discipline in `07-security-and-secrets/secrets-policy.md` and `07-security-and-secrets/ai-specific-security.md`.

## When to use this hook

- You routinely run agents in projects where tool output can include logs, environment dumps, or git history that may contain accidental secrets.
- You want a flag, not a block — the agent should still complete the turn, with the warning visible.

## When *not* to use this hook

- You want hard prevention. This is a flag, not a block; for prevention, deny the offending tool calls in `settings.json`.
- Your project's tool output is high-volume and grep-heavy; the hook will produce false positives. Either tune the patterns, narrow the matcher, or move to a redacting variant.

## Hook script

The script ships as a sibling file: [`post-tool-use-secrets-flag.sh`](./post-tool-use-secrets-flag.sh). It's checked in without the execute bit — copy it to `.claude/hooks/post-tool-use-secrets-flag.sh` in your project and `chmod +x` to make it runnable. The full source is mirrored below for reading convenience.

```bash
#!/usr/bin/env bash
# .claude/hooks/post-tool-use-secrets-flag.sh
#
# PostToolUse hook: scan tool output for patterns that look like leaked
# secrets. Print a warning to stdout if a match is found. Does not block
# or redact.
#
# Input on stdin: JSON with .tool_name, .tool_input, .tool_response.
# Exit 0 to allow the agent to continue.

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
```

## Wiring it up

In `.claude/settings.json`:

```jsonc
{
  "hooks": {
    "PostToolUse": [
      {
        "matcher": "*",
        "hooks": [
          { "type": "command", "command": ".claude/hooks/post-tool-use-secrets-flag.sh" }
        ]
      }
    ]
  }
}
```

The `"matcher": "*"` runs the hook for every tool. Narrow it (e.g. `"Bash(*)"`) if you only want to scan shell output.

## Tuning

- The pattern list is a starting point. Add patterns specific to your stack (Stripe, Twilio, internal token formats). Remove patterns that produce noise.
- For high-volume tool output, narrow the matcher in `settings.json` to the tools that produce risky output.
- For redaction instead of flagging, modify the script to print a redacted version to stdout. Note that the agent then sees the redacted output, which can break workflows that depend on the original.

## Limitations

- Pattern-based detection has false positives and false negatives. Treat it as a safety net, not a primary control.
- The hook runs synchronously; complex regex over very large output can slow turns.
- Hooks run on the user's machine, with the user's permissions. They are not a substitute for upstream secret hygiene (see `07-security-and-secrets/secrets-policy.md`).

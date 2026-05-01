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

input="$(cat)"
output="$(echo "$input" | jq -r '.tool_response.content // .tool_response // ""')"

# Fail loud, not closed: if extraction returns empty, warn, surface the
# observed top-level keys, and fall back to scanning the raw input.
if [ -z "$output" ]; then
  echo "WARNING: secrets-flag hook found no .tool_response content."
  echo "  Claude Code's hook input schema may have shifted; falling back to raw input."
  keys="$(echo "$input" | jq -r 'keys | join(", ")' 2>/dev/null || echo '<unparseable>')"
  echo "  top-level keys observed: ${keys}"
  output="$input"
fi

# Patterns to flag.
patterns=(
  'AKIA[0-9A-Z]{16}'
  'sk-[A-Za-z0-9]{20,}'
  'ghp_[A-Za-z0-9]{36,}'
  'Bearer [A-Za-z0-9._-]{20,}'
  '(api[_-]?key|secret|token|password)[^A-Za-z0-9]{1,3}[A-Za-z0-9._-]{16,}'
)

# Lines containing these markers are treated as placeholders and dropped.
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
- **Placeholder filter.** The script drops flagged lines that also contain `YOUR_`, `EXAMPLE_`, `REPLACE_`, `FIXME`, `TODO`, `placeholder`, or `XXXXXXXXXXXX`. Adjust the `placeholder_markers` variable to fit your codebase's conventions. Tune carefully — an over-broad filter creates the same silent-no-op problem the empty-extraction guard exists to prevent.

## Failure modes

- **Schema drift.** Claude Code's hook input shape has historically been stable but is not contractual. The `if [ -z "$output" ]` block exists so a future shape change surfaces as a noisy warning rather than a silent zero-coverage hook. If you see that warning in real use, update the `jq` extraction path.
- **False positives.** Documentation pages with example tokens (`sk-AAAA...`, `ghp_AAAA...`), test fixtures, and snapshot output can all trip the patterns. The placeholder filter handles the obvious cases; for project-specific noise, narrow the matcher in `settings.json` upstream of the hook.
- **False negatives.** Pattern-based detection is a safety net, not a primary control. Treat upstream secret hygiene (`07-security-and-secrets/secrets-policy.md`) as the real defense.

## Limitations

- Pattern-based detection has false positives and false negatives. Treat it as a safety net, not a primary control.
- The hook runs synchronously; complex regex over very large output can slow turns.
- Hooks run on the user's machine, with the user's permissions. They are not a substitute for upstream secret hygiene (see `07-security-and-secrets/secrets-policy.md`).

# Improvements

A working tracker for actionable items identified in review of `v2.1.0`. Each entry is concrete and file-anchored. Close items by removing them from this file. Delete the file once it's empty.

## Claude adapter

### 4. Caveat the deny-pattern globs in `settings.json`

- **Files:** `05-tool-adapters/claude/settings.json`, `examples/imported-into-project/.claude/settings.json`
- **Change:** add a JSONC comment above the `deny` block noting that patterns like `Bash(* prod*)` and `Bash(git push * main*)` rely on Claude Code's command tokenization; forkers should test them against the actual command shapes their stack produces.
- **Why:** the harness preaches "tighten further per project" but doesn't ask forkers to verify the patterns fire as intended.

### 5. Harden the secrets-flag hook against silent failure

- **Files:** `05-tool-adapters/claude/hooks/post-tool-use-secrets-flag.sh`, `05-tool-adapters/claude/hooks/post-tool-use-secrets-flag.md`, `examples/imported-into-project/.claude/hooks/post-tool-use-secrets-flag.sh`
- **State:** `jq -r '.tool_response.content // .tool_response // ""'` falls back to empty string when Claude Code's hook schema changes — the hook becomes a silent no-op.
- **Change:** when extraction returns empty, either (a) emit a "hook input shape unrecognized" warning and grep over the raw input as a fallback, or (b) print the top-level keys for debugging. Fail loud, not closed.

### 6. Soften the default secrets regex

- **Files:** `05-tool-adapters/claude/hooks/post-tool-use-secrets-flag.sh` (and mirror in the example)
- **State:** `(api[_-]?key|secret|token|password)[^A-Za-z0-9]{1,3}[A-Za-z0-9._-]{16,}` and `Bearer [A-Za-z0-9._-]{20,}` fire on documentation placeholders and example bodies.
- **Change:** either (a) skip values starting with `<`, `{{`, or `$` (common placeholder shapes), or (b) add a one-line comment near the patterns naming the most common false-positive shapes so forkers know what to tune.

## Examples directory

### 7. Address the `CLAUDE.md` / `AGENTS.md` overlap in the example

- **Files:** `examples/imported-into-project/CLAUDE.md`, `examples/imported-into-project/AGENTS.md`, `examples/imported-into-project/README.md`
- **State:** ~50 lines of duplicated doctrine across the two memory files. The example's README calls `AGENTS.md` "a mirror" but doesn't say what a maintainer should do when the two drift.
- **Change:** add a short "Maintenance posture" note in the example's README explaining the intentional duplication (two tool families, two memory files), and name the chosen sync stance — edit one and copy, generate one from the other, or accept drift.

### 8. Comment the example `settings.json` about the hook exec bit

- **File:** `examples/imported-into-project/.claude/settings.json`
- **Change:** one JSONC comment above the `hooks` block reminding forkers to `chmod +x` after copying the script. The settings file currently points at a non-executable script — a working contradiction without the comment.

## Security and regulatory

### 9. Frame `gdpr-data-handling.md` as one regulator, not the regulator

- **File:** `07-security-and-secrets/gdpr-data-handling.md` (optionally a new sibling)
- **Change:** opening paragraph clarifying GDPR is one regime among peers (SOC2, HIPAA, PCI, etc.); the harness ships an engineering posture for GDPR specifically because it's the broadest hit for a European audience. Optionally stub `07-security-and-secrets/regulatory-overview.md` with "talk to counsel" pointers for peer regimes.
- **Why:** as the only regulatory file, the page currently implies the harness is Eurocentric.

## Repo hygiene

### 10. Add a link / markdown checker

- **Files:** new `scripts/check-links.sh` (and optionally `.github/workflows/links.yml`)
- **Change:** small script that walks the markdown corpus, validates internal `./*.md` links and section anchors, and exits non-zero on the first miss. Wire it into CI on PR.
- **Why:** `CONTRIBUTING.md` explicitly invites broken-link fixes as PR-worthy; catching them in CI saves the round trip.

---

Once an item is addressed, remove its section. When the file is empty, remove the file.

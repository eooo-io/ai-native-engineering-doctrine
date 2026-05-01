# Improvements

A working tracker for actionable items identified in review of `v2.1.0`. Each entry is concrete and file-anchored. Close items by removing them from this file. Delete the file once it's empty.

## Repo hygiene

### 10. Add a link / markdown checker

- **Files:** new `scripts/check-links.sh` (and optionally `.github/workflows/links.yml`)
- **Change:** small script that walks the markdown corpus, validates internal `./*.md` links and section anchors, and exits non-zero on the first miss. Wire it into CI on PR.
- **Why:** `CONTRIBUTING.md` explicitly invites broken-link fixes as PR-worthy; catching them in CI saves the round trip.

---

Once an item is addressed, remove its section. When the file is empty, remove the file.

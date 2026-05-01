# Improvements

A working tracker for actionable items identified in review of `v2.1.0`. Each entry is concrete and file-anchored. Close items by removing them from this file. Delete the file once it's empty.

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

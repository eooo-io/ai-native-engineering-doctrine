#!/usr/bin/env bash
# scripts/check-links.sh
#
# Validate internal markdown links and relative-path references across
# the repo. External links (http://, https://, mailto:) are skipped.
#
# What this checks:
#   - For every markdown link of the form `[text](path)` in any *.md
#     file, the target file or directory exists.
#   - Anchors (`...#section`) are validated against the slugified
#     headings of the target markdown file. Non-markdown anchor targets
#     are skipped.
#
# Exit code: 0 on success, 1 on any broken link.
#
# Usage: scripts/check-links.sh

set -euo pipefail

repo_root="$(git rev-parse --show-toplevel)"
cd "$repo_root"

# Collect all markdown files, excluding .git/ and node_modules/.
mapfile -t files < <(find . -type f -name '*.md' -not -path './.git/*' -not -path './node_modules/*' | sort)

failures=0

# slugify_heading reads a markdown heading line and prints the
# GitHub-style anchor slug. The implementation is a pragmatic
# approximation: lowercase, drop characters that GitHub drops, and
# collapse spaces to dashes. It will mismatch on exotic Unicode but
# handles every heading shape currently in the repo.
slugify_heading() {
  local line="$1"
  line="${line#"${line%%[!#]*}"}"   # strip leading #'s
  line="${line# }"                  # strip the single space after #'s
  line="$(printf '%s' "$line" | tr '[:upper:]' '[:lower:]')"
  # Drop punctuation GitHub strips, keep alnum/space/hyphen/underscore.
  line="$(printf '%s' "$line" | LC_ALL=C sed -E 's/[^a-z0-9 _-]//g')"
  line="$(printf '%s' "$line" | tr ' ' '-')"
  printf '%s\n' "$line"
}

# Extract anchors that exist in a markdown file.
collect_anchors() {
  local target="$1"
  grep -E '^#{1,6} ' "$target" 2>/dev/null | while IFS= read -r heading; do
    slugify_heading "$heading"
  done
}

for f in "${files[@]}"; do
  dir="$(dirname "$f")"

  # Pull markdown links: ](url). Use grep with -o; tolerate parentheses
  # in URLs by stopping at the first close-paren (good enough here).
  links="$(grep -oE '\]\([^)]+\)' "$f" || true)"
  [ -z "$links" ] && continue

  while IFS= read -r raw; do
    # Strip the leading `](` and trailing `)`.
    url="${raw#](}"
    url="${url%)}"

    # Skip empties and external schemes.
    case "$url" in
      ''|\#*|http://*|https://*|mailto:*|tel:*) continue ;;
    esac

    # Split into path and anchor.
    path="${url%%#*}"
    anchor=""
    if [[ "$url" == *"#"* ]]; then
      anchor="${url#*#}"
    fi

    # Empty path with only an anchor refers to the same file.
    if [ -z "$path" ]; then
      target="$f"
    else
      target="$(cd "$dir" && readlink -f -- "$path" 2>/dev/null || true)"
      if [ -z "$target" ] || [ ! -e "$target" ]; then
        printf 'BROKEN: %s -> %s (target missing)\n' "$f" "$url" >&2
        failures=$((failures + 1))
        continue
      fi
    fi

    # Anchor validation, if present. Only meaningful for markdown files.
    # Capture anchors into a string first so the membership check doesn't
    # race with `set -o pipefail` and SIGPIPE on early-exit grep.
    if [ -n "$anchor" ]; then
      case "$target" in
        *.md)
          anchors="$(collect_anchors "$target")"
          if [[ $'\n'"$anchors"$'\n' != *$'\n'"$anchor"$'\n'* ]]; then
            printf 'BROKEN: %s -> %s (anchor missing)\n' "$f" "$url" >&2
            failures=$((failures + 1))
          fi
          ;;
      esac
    fi
  done <<< "$links"
done

if [ "$failures" -gt 0 ]; then
  printf '\n%d broken link(s) found.\n' "$failures" >&2
  exit 1
fi

printf 'All internal markdown links resolve.\n'

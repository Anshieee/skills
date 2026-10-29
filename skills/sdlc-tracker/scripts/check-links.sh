#!/usr/bin/env bash
# Check links in one or more markdown files.
# Usage: scripts/check-links.sh <file.md> [more.md ...]
# Fails on a missing local target or an insecure http link.
# Skips in-page anchors and https links.
set -euo pipefail

if [ "$#" -lt 1 ]; then
  echo "usage: check-links.sh <file.md> [more.md ...]" >&2
  exit 2
fi

bad=0

for f in "$@"; do
  if [ ! -f "$f" ]; then
    echo "missing file: $f"
    bad=1
    continue
  fi

  dir="$(dirname "$f")"

  while IFS= read -r target; do
    case "$target" in
      "" | "#"*) continue ;;
    esac

    case "$target" in
      https://*) continue ;;
      http://*)
        echo "insecure link: $f -> $target"
        bad=1
        continue
        ;;
    esac

    path="${target%%#*}"
    [ -z "$path" ] && continue

    if [ ! -e "$dir/$path" ]; then
      echo "missing link: $f -> $target"
      bad=1
    fi
  done < <(grep -oE '\]\([^)]+\)' "$f" | sed -E 's/^\]\(//; s/\)$//' || true)
done

if [ "$bad" -eq 0 ]; then
  echo "links ok"
fi

exit "$bad"

#!/usr/bin/env bash
# Render a Graphviz diagram to svg and png.
# Usage: scripts/render.sh <diagram.gv> [outdir]
# When dot is missing the source file is left in place and the script exits 0,
# so a run without graphviz still finishes.
set -euo pipefail

if [ "$#" -lt 1 ]; then
  echo "usage: render.sh <diagram.gv> [outdir]" >&2
  exit 2
fi

src="$1"
outdir="${2:-$(dirname "$src")}"

if [ ! -f "$src" ]; then
  echo "render.sh: no such file: $src" >&2
  exit 2
fi

base="$(basename "$src" .gv)"
mkdir -p "$outdir"

if command -v dot >/dev/null 2>&1; then
  dot -Tsvg "$src" -o "$outdir/$base.svg"
  dot -Tpng "$src" -o "$outdir/$base.png"
  echo "rendered: $outdir/$base.svg $outdir/$base.png"
else
  echo "dot not found: left $src unrendered."
  echo "Install graphviz and rerun, or keep the Mermaid default."
fi

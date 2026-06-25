#!/usr/bin/env bash
# Refresh only the bundled Windows exe (no cargo task required).
# To regenerate the WHOLE plugin (docs + exe), prefer:  cargo plugin
# Usage: ./plugin/scripts/bundle.sh
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PLUGIN_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"        # plugin/
REPO_ROOT="$(cd "$PLUGIN_DIR/.." && pwd)"         # grsai repo root
DEST="$PLUGIN_DIR/skills/grsai/bin/grsai.exe"

echo "==> Building grsai (release)..."
(cd "$REPO_ROOT" && cargo build --release)

SRC="$REPO_ROOT/target/release/grsai.exe"
if [[ ! -f "$SRC" ]]; then
  echo "ERROR: Windows release artifact not found at $SRC" >&2
  echo "       Build for the Windows target so the artifact is a .exe, then re-run." >&2
  exit 1
fi

mkdir -p "$(dirname "$DEST")"
cp "$SRC" "$DEST"
echo "==> Bundled binary refreshed: $DEST"

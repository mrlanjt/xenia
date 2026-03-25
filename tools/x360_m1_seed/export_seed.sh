#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "$0")/../.." && pwd)"
OUT_DIR="${1:-$ROOT_DIR/x360-m1-runner-seed}"
ARCHIVE_PATH="${2:-$ROOT_DIR/x360-m1-runner-seed.tar.gz}"

rm -rf "$OUT_DIR" "$ARCHIVE_PATH"
mkdir -p "$OUT_DIR/src/xenia"

cp "$ROOT_DIR/LICENSE" "$OUT_DIR/"
cp "$ROOT_DIR/README.md" "$OUT_DIR/README_UPSTREAM_XENIA.md"

# Base (filtered for macOS M1 bootstrap)
mkdir -p "$OUT_DIR/src/xenia/base"
rsync -a "$ROOT_DIR/src/xenia/base/" "$OUT_DIR/src/xenia/base/" \
  --exclude 'testing/' \
  --exclude 'premake5.lua' \
  --exclude 'app_win32.manifest' \
  --exclude 'debug_visualizers.natvis' \
  --exclude '*_win.*' \
  --exclude '*_android.*' \
  --exclude 'platform_win.h' \
  --exclude 'platform_linux.h' \
  --exclude 'console_win.cc' \
  --exclude 'main_win.h' \
  --exclude 'clock_x64.cc' \
  --exclude 'system_gnulinux.cc' \
  --exclude 'socket_win.cc'

# VFS (filtered)
mkdir -p "$OUT_DIR/src/xenia/vfs"
rsync -a "$ROOT_DIR/src/xenia/vfs/" "$OUT_DIR/src/xenia/vfs/" \
  --exclude 'testing/' \
  --exclude 'premake5.lua'

# CPU (runtime-focused)
cp -R "$ROOT_DIR/src/xenia/cpu/hir" "$OUT_DIR/src/xenia/cpu_hir"
rsync -a "$ROOT_DIR/src/xenia/cpu/ppc/" "$OUT_DIR/src/xenia/cpu_ppc/" \
  --exclude 'testing/'

# Kernel util + memory/xbox primitives
cp -R "$ROOT_DIR/src/xenia/kernel/util" "$OUT_DIR/src/xenia/kernel_util"
cp "$ROOT_DIR/src/xenia/memory.h" "$ROOT_DIR/src/xenia/memory.cc" "$ROOT_DIR/src/xenia/xbox.h" "$OUT_DIR/src/xenia/"

# Audit + inventory
cp "$ROOT_DIR/tools/x360_m1_seed/AUDIT_MANIFEST_zh.md" "$OUT_DIR/"
( cd "$OUT_DIR" && find . -type f | sort ) > "$OUT_DIR/COPY_LIST.txt"

tar -czf "$ARCHIVE_PATH" -C "$(dirname "$OUT_DIR")" "$(basename "$OUT_DIR")"

echo "Seed directory: $OUT_DIR"
echo "Archive: $ARCHIVE_PATH"
echo "File count: $(find "$OUT_DIR" -type f | wc -l)"
ls -lh "$ARCHIVE_PATH"

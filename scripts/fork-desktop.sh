#!/usr/bin/env bash
# Fork: build the Linux AppImage and install it over ~/.local/share/learnharness.
# The launcher (~/.local/share/applications/learnharness.desktop) and the
# pool key (~/.config/LearnHarness/auth.json) live outside the build.
set -euo pipefail
cd "$(dirname "$0")/.."

# Shells inside Electron apps (T3) export ELECTRON_RUN_AS_NODE, which turns the
# packaged binary into plain Node; this machine's ANTHROPIC_* must not leak in.
unset ELECTRON_RUN_AS_NODE ANTHROPIC_API_KEY ANTHROPIC_AUTH_TOKEN ANTHROPIC_BASE_URL

ELECTRON_SKIP_BINARY_DOWNLOAD=1 PUPPETEER_SKIP_DOWNLOAD=1 npm ci
npm run build
node scripts/build-server.mjs
npx electron-builder --linux AppImage --x64 --publish never

install_dir="${XDG_DATA_HOME:-$HOME/.local/share}/learnharness"
mkdir -p "$install_dir"
mv dist/LearnHarness-*-x86_64.AppImage "$install_dir/LearnHarness.AppImage"
cp build/icon.png "$install_dir/icon.png"
# The build trees take ~2.5 GB; the installed AppImage is all that's needed.
rm -rf dist .next/cache .next/dev
echo "installed $install_dir/LearnHarness.AppImage"

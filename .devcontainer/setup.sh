#!/usr/bin/env bash
set -e

echo "[devcontainer] Starting setup script"

# Create and activate a Python venv in the workspace
python3 -m venv .venv || true
# shellcheck disable=SC1091
source .venv/bin/activate

pip install --upgrade pip setuptools wheel

# Install ONNX runtime and video-processing helpers
pip install onnx onnxruntime opencv-python-headless ffmpeg-python boto3

# Enable corepack and prepare pnpm
corepack enable || true
corepack prepare pnpm@latest --activate || npm i -g pnpm

# Ensure rust components and install tauri-cli
rustup component add clippy rustfmt || true
cargo install tauri-cli --locked || true

# Install frontend dependencies (pnpm workspace)
if command -v pnpm >/dev/null 2>&1; then
  echo "[devcontainer] Installing pnpm workspace dependencies"
  pnpm -w install --silent || true
else
  echo "[devcontainer] pnpm not found, skipping JS deps install"
fi

echo "[devcontainer] Setup complete. Python venv at .venv is ready."
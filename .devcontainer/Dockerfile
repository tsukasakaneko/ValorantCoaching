# Base image
FROM mcr.microsoft.com/devcontainers/base:noble

# Install system packages required for Tauri, ONNX runtime and video processing
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
      python3 python3-pip python3-venv ffmpeg \
      libwebkit2gtk-4.0-dev libgtk-3-dev libssl-dev build-essential pkg-config libsqlite3-dev \
      curl git ca-certificates && \
    rm -rf /var/lib/apt/lists/*

# Ensure latest pip
RUN python3 -m pip install --upgrade pip setuptools wheel

# Enable corepack for pnpm (Node will be installed by node-asdf feature)
RUN corepack enable || true

# Make sure /workspaces is owned by vscode user (in case of mount issues)
RUN mkdir -p /workspaces && chown -R vscode:vscode /workspaces

# Set working directory
WORKDIR /workspaces/ValorantCoaching

# Expose common ports (change if needed)
EXPOSE 3000 8080

# Note: heavy Python packages (torch) are intentionally not preinstalled because
# ONNX runtime is used for inference. If you need to convert models or train, run
# those steps on a machine with GPU or adjust this Dockerfile.

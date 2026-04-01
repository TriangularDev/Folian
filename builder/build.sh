#!/bin/bash
set -e

# === Configuration ===
_repo_dir="$HOME/Folian"
_builder_dir="$_repo_dir/builder"
_os_dir="$_repo_dir/src"
_output_dir="$HOME/Folian_Output"
_runner_name="$(hostname)"
_image_name="folian-builder-${_runner_name}"
_container_name="${_image_name}"

# === Preparation ===
echo "Preparing Folian build environment..."
cd "$_repo_dir"

# Get short commit hash
_commit_hash=$(git rev-parse --short HEAD)

# Ensure output directory exists
mkdir -p "$_output_dir"

# Debug info
echo "Commit hash: $_commit_hash"
echo "Runner name: $_runner_name"
echo "Output directory: $_output_dir"

# === Build Docker Image ===
echo "Building Docker image: $_image_name"
cd "$_builder_dir"
docker build -t "$_image_name" .

# === Run Docker Container (attached, auto-remove) ===
echo "Running Docker container (privileged mode)..."
docker run -it --rm \
  --privileged \
  --name "$_container_name" \
  -v "$_os_dir:/src" \
  -v "$_output_dir:/Folian_Output" \
  "$_image_name"

# === Verify Output ===
echo "Build completed. ISO output contents:"
ls -lh "$_output_dir" || true

echo "Folian ISO build finished successfully!"

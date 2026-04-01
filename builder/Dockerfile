# Use Debian Trixie as the base image
FROM debian:trixie

# Run as root
USER root

# Prevent interactive prompts
ENV DEBIAN_FRONTEND=noninteractive

# Update system and install dependencies
RUN apt update && apt install -y \
    live-build \
    git \
    debian-archive-keyring \
    sudo \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /src

# Default command: configure and build Folian ISO, then copy to output
CMD lb config --architecture amd64 && \
    lb build --verbose --debug && \
    mkdir -p /Output && \
    cp -r ./live-image* /Output/ && \
    echo "ISO build complete. Files copied to /Output."

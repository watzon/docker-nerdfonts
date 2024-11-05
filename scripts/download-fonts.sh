#!/bin/bash

# Get the latest release info
RELEASE_INFO=$(curl -s https://api.github.com/repos/ryanoasis/nerd-fonts/releases/latest)

# Create temporary directory for downloads
mkdir -p /tmp/fonts
cd /tmp/fonts

# Download and extract all .tar.xz font archives
echo "$RELEASE_INFO" | jq -r '.assets[] | select(.name | endswith(".tar.xz")) | .browser_download_url' | \
while read -r url; do
    echo "Downloading: $url"
    curl -L -O "$url"
done

# Extract all archives
for archive in *.tar.xz; do
    echo "Extracting: $archive"
    tar xf "$archive"
    rm "$archive"
done

# Move fonts to final destination
mkdir -p /usr/share/fonts/nerd-fonts
mv *.ttf *.otf /usr/share/fonts/nerd-fonts/ 2>/dev/null || true

# Cleanup
cd /
rm -rf /tmp/fonts 
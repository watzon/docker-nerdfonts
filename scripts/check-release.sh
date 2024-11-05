#!/bin/bash

# Get the latest release version from GitHub API
LATEST_VERSION=$(curl -s https://api.github.com/repos/ryanoasis/nerd-fonts/releases/latest | jq -r .tag_name)

# Create version file if it doesn't exist
if [ ! -f .last_version ]; then
    echo "v0.0.0" > .last_version
fi

# Read the last processed version
LAST_VERSION=$(cat .last_version)

if [ "$LATEST_VERSION" != "$LAST_VERSION" ]; then
    echo "New version found: $LATEST_VERSION"
    echo "$LATEST_VERSION" > .last_version
    echo "should_build=true" >> $GITHUB_OUTPUT
    echo "version=$LATEST_VERSION" >> $GITHUB_OUTPUT
else
    echo "No new version found"
    echo "should_build=false" >> $GITHUB_OUTPUT
fi 
FROM alpine:latest

# Install required packages for downloading and extracting
RUN apk add --no-cache curl jq tar xz

# Copy the download script
COPY scripts/download-fonts.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/download-fonts.sh

# Download and extract fonts
RUN /usr/local/bin/download-fonts.sh

# Remove packages no longer needed
RUN apk del curl jq tar xz

# Set working directory to fonts location
WORKDIR /usr/share/fonts/nerd-fonts

# This container is meant to be used as a source for fonts
CMD ["ls", "-la"] 
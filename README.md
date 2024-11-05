# Nerd Fonts Docker Container

This project provides a Docker container with pre-installed Nerd Fonts, designed to be used as a font source for other Docker containers and workflows. Instead of downloading Nerd Fonts repeatedly in your workflows, you can use this container as a font source.

## Features

- Automatically tracks new Nerd Fonts releases
- Weekly builds to ensure latest fonts are available
- All Nerd Fonts included and ready to use
- Minimal container size (Alpine-based)
- Automated GitHub Actions workflow for builds

## Usage

### Basic Usage

Pull the container:

```bash
docker pull ghcr.io/watzon/docker-nerdfonts:latest
```

### Using with Docker Compose

To use the fonts in another container, you can copy them during the build process:

```yaml
services:
  your-app:
    build:
      context: .
      dockerfile: Dockerfile
    volumes:
      - nerd-fonts:/usr/share/fonts/nerd-fonts

volumes:
  nerd-fonts:
    name: nerd-fonts
```

### Using in a Dockerfile

Copy fonts from this container in a multi-stage build:

```dockerfile
# First stage - copy fonts
FROM ghcr.io/watzon/docker-nerdfonts:latest as fonts

# Your final image
FROM your-base-image:tag

# Copy fonts from the fonts stage
COPY --from=fonts /usr/share/fonts/nerd-fonts /usr/share/fonts/nerd-fonts

# Optional: update font cache if needed
RUN fc-cache -fv
```

## Tags

- `latest` - Always points to the most recent build
- `vX.X.X` - Specific version tags matching Nerd Fonts releases

## Automated Updates

This container is automatically rebuilt weekly through GitHub Actions. It checks for new Nerd Fonts releases and rebuilds when updates are available. The workflow:

1. Checks for new Nerd Fonts releases
2. Builds and pushes new container images when updates are found
3. Maintains version tracking through git commits

## Local Development

To build the container locally:

```bash
docker build -t nerdfonts .
```

## License

This project is provided under MIT License. Note that Nerd Fonts has its own license terms which can be found at [the Nerd Fonts repository](https://github.com/ryanoasis/nerd-fonts).

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## Notes

- The container is meant to be used as a font source, not as a running container
- All fonts are stored in `/usr/share/fonts/nerd-fonts/`
- The container automatically tracks and updates with new Nerd Fonts releases 
# Darkoza CLI

Darkoza CLI is an open-source AI coding agent for the terminal, branded for Darkoza and built from the Kilo Code CLI codebase.

## Install

### Linux / macOS

    curl -fsSL https://raw.githubusercontent.com/hamidrezamirhosseini33-arch/darkoza-cli/main/install.sh | bash

The installer detects the operating system and CPU architecture and installs `darkoza` into `~/.local/bin`.

### Windows

Download the Windows x64 ZIP from the GitHub Releases page, extract `darkoza.exe`, and put it on PATH.

## Parspack

Darkoza supports OpenAI-compatible Parspack models. For provider-key mode:

    export DARKOZA_API_KEY="..."
    export DARKOZA_MODEL="xiaomi/mimo-v2.5"
    export DARKOZA_BASE_URL="https://ai.parspack.com/v1"

    darkoza doctor
    darkoza models
    darkoza

The public source and release artifacts do not contain a Parspack API key.
## Global release

Version tags such as `v0.1.0` automatically build release artifacts for:

- Linux x64
- Linux arm64
- macOS arm64 (Apple Silicon)
- macOS x64 (Intel)
- Windows x64

Each release is published as a GitHub Release with architecture-specific archives.

## Free hosted access

Darkoza is designed to support a hosted free tier backed by Darkoza's server-side Parspack integration. The upstream credential remains server-side; it is never shipped to clients.

## License

MIT. Upstream Kilo Code attribution and license notices are retained.
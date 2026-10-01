#!/usr/bin/env bash
set -euo pipefail

REPO="${DARKOZA_CLI_REPO:-hamidrezamirhosseini33-arch/darkoza-cli}"
INSTALL_DIR="${DARKOZA_INSTALL_DIR:-$HOME/.local/bin}"

die() {
  echo "Darkoza installer: $*" >&2
  exit 1
}

version="${DARKOZA_VERSION:-latest}"
os="$(uname -s)"
arch="$(uname -m)"

case "$os" in
  Linux)
    case "$arch" in
      x86_64|amd64) asset_arch="linux-x64" ;;
      aarch64|arm64) asset_arch="linux-arm64" ;;
      *) die "Unsupported Linux architecture: $arch" ;;
    esac
    ext="tar.gz"
    ;;
  Darwin)
    case "$arch" in
      arm64) asset_arch="darwin-arm64" ;;      x86_64) asset_arch="darwin-x64" ;;
      *) die "Unsupported macOS architecture: $arch" ;;
    esac
    ext="zip"
    ;;
  *)
    die "This installer supports Linux and macOS. Windows users: use GitHub Releases."
    ;;
esac

if [ "$version" = "latest" ]; then
  tag="$(curl -fsSL -H "Accept: application/vnd.github+json" "https://api.github.com/repos/${REPO}/releases/latest" | python3 -c "import json,sys; print(json.load(sys.stdin)['tag_name'])")" || die "Could not resolve latest release"
else
  tag="v${version#v}"
fi

version="${tag#v}"
tmp="$(mktemp -d)"
trap 'rm -rf "$tmp"' EXIT

archive="darkoza-${asset_arch}-${version}.${ext}"
url="https://github.com/${REPO}/releases/download/${tag}/${archive}"
echo "Installing Darkoza CLI ${version} for ${asset_arch}..."
curl -fL --retry 3 --retry-all-errors -o "$tmp/$archive" "$url" || die "Download failed: $url"

mkdir -p "$INSTALL_DIR"
if [ "$ext" = "tar.gz" ]; then
  tar -xzf "$tmp/$archive" -C "$tmp"
  src="$tmp/darkoza"else
  unzip -q "$tmp/$archive" -d "$tmp/unpacked"
  src="$tmp/unpacked/darkoza"
fi

test -f "$src" || die "Release archive did not contain darkoza"
install -m 0755 "$src" "$INSTALL_DIR/darkoza"
echo "Installed: $INSTALL_DIR/darkoza"
case ":$PATH:" in
  *":$INSTALL_DIR:"*) ;;
  *) echo "Add $INSTALL_DIR to PATH, then run: darkoza" ;;
esac
echo "Run: $INSTALL_DIR/darkoza --help"
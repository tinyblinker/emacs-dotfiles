#!/usr/bin/env bash
#
# install-dependencies.sh
#
# Install the system packages needed by this Emacs configuration.
# Target distribution: Arch Linux (uses pacman).
#
# Usage:
#   chmod +x install-dependencies.sh
#   ./install-dependencies.sh

set -euo pipefail

# ---------------------------------------------------------------------------
# Required packages
# ---------------------------------------------------------------------------
# ripgrep       : fast text search engine (used by consult-ripgrep)
# fd            : fast file search (used by dirvish)
# chafa         : render images in the terminal (dirvish image preview)
# poppler       : PDF tools, provides pdftoppm (dirvish PDF preview)
# graphviz      : graph layout tools, provides fdp/dot (org-roam graph)
# cmake         : build system (compiles the vterm module)
# libvterm      : terminal emulation library (required by vterm)
REQUIRED=(
  ripgrep
  fd
  chafa
  poppler
  graphviz
  cmake
  libvterm
)

echo "==> Installing required packages..."
sudo pacman -S --needed --noconfirm "${REQUIRED[@]}"

# ---------------------------------------------------------------------------
# Optional packages (nice to have, skip if you do not need the feature)
# ---------------------------------------------------------------------------
# ffmpegthumbnailer : video thumbnails in dirvish
# texlive-core      : LaTeX engine used by org-mode's dvisvgm preview
OPTIONAL=(
  ffmpegthumbnailer
  texlive-core
)

echo "==> Installing optional packages..."
sudo pacman -S --needed --noconfirm "${OPTIONAL[@]}"

# ---------------------------------------------------------------------------
# Non-pacman dependencies
# ---------------------------------------------------------------------------
echo ""
echo "==> The following are NOT installed by pacman:"
echo ""
echo "  Rust LSP server (rust-analyzer), via rustup:"
echo "    rustup component add rust-analyzer"
echo ""
echo "  Mermaid diagrams (ob-mermaid), via npm:"
echo "    npm install -g @mermaid-js/mermaid-cli"
echo ""
echo "  Tree-sitter grammars are compiled separately and placed"
echo "  in ~/.config/emacs/tree-sitter/ (see the README)."

echo ""
echo "==> Done."

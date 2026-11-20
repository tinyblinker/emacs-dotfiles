#!/usr/bin/env bash
set -euo pipefail

# ---------------------------------------------------------------------------
# Required packages
# ---------------------------------------------------------------------------
# ripgrep       : fast text search engine (used by consult-ripgrep)
# fd            : fast file search (used by dirvish)
# chafa         : render images in the terminal (dirvish image preview)
# poppler       : PDF tools, provides pdftoppm (dirvish PDF preview)
# graphviz      : graph layout tools, provides fdp/dot (org-roam graph)
# bash linter : shellcheck
# bash formatter : shfmt
# bash lsp : bash-language-server
# c lsp : clangd, clang-tidy, clang-format
REQUIRED=(
  ripgrep
  fd
  chafa
  poppler
  graphviz
  ttf-sarasa-gothic
  shellcheck
  shfmt
  bash-language-server
  clang
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
echo "  Rust tools (rust-analyzer, rustfmt, clippy), via rustup:"
echo "    rustup component add rust-analyzer rustfmt clippy"
echo ""
echo "  Mermaid diagrams (ob-mermaid), via npm:"
echo "    npm install -g @mermaid-js/mermaid-cli"
echo ""
echo ""
echo "==> Done."

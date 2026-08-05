<h1 align="center">
  <img src="https://www.gnu.org/software/emacs/images/emacs.png" alt="Emacs" width="32">
  emacs-dotfiles
</h1>

<p align="center">
  <a href="https://www.gnu.org/software/emacs/">
    <img src="https://img.shields.io/badge/Emacs-30.2-%237F5AB6?style=flat-square&logo=gnu-emacs&logoColor=white" alt="Emacs 30.2">
  </a>
  <a href="https://github.com/tinyblinker/emacs-dotfiles/stargazers">
    <img src="https://img.shields.io/github/stars/tinyblinker/emacs-dotfiles?style=flat-square&color=D0BCFF" alt="Stars">
  </a>
  <a href="https://github.com/tinyblinker/emacs-dotfiles/blob/main/LICENSE">
    <img src="https://img.shields.io/github/license/tinyblinker/emacs-dotfiles?style=flat-square&color=D0BCFF" alt="License">
  </a>
  <a href="https://github.com/tinyblinker/emacs-dotfiles/commits/main">
    <img src="https://img.shields.io/github/last-commit/tinyblinker/emacs-dotfiles?style=flat-square&color=D0BCFF" alt="Last Commit">
  </a>
</p>

<p align="center">
  <sup>Minimal · Fast · Rust + Org</sup>
</p>

---

## About

A lightweight Emacs configuration focused on two things:

- &#x1F980; **Rust development** via eglot + rust-analyzer
- &#x1F4DD; **Org-mode** for notes and writing

Heavily pruned from [Crafted Emacs](https://github.com/SystemCrafters/crafted-emacs) — stripped of framework overhead, cosmetic plugins, and anything not serving the two core workflows above.

## Quick Start

```bash
# Prerequisites
rustup component add rust-analyzer

# Clone
git clone https://github.com/tinyblinker/emacs-dotfiles.git ~/.config/emacs
```

Launch Emacs. Packages install automatically on first run.

## Features

| Category | Stack |
|----------|-------|
| Minibuffer | `vertico` + `orderless` + `marginalia` — vertical fuzzy completion |
| In-buffer | `corfu` + `cape` — popup completion + extra backends |
| Search | `consult` — `consult-line`, `consult-ripgrep`, etc. |
| LSP | `eglot` — auto-starts rust-analyzer on `.rs` files |
| Cargo | `rust-mode` — `cargo build/check/test/clippy/fmt` |
| Syntax | `treesit-auto` — tree-sitter grammars for Rust & Bash |
| Notes | `denote` — structured org-mode note-taking |
| Font | `JetBrainsMono Nerd Font Mono` 19pt — coding font with icons |
| Theme | `modus-vivendi` — built-in high-contrast dark theme |

## Keybindings

### Rust / Cargo

| Keys | Command |
|------|---------|
| `C-c C-c C-u` | `cargo build` |
| `C-c C-c C-k` | `cargo check` |
| `C-c C-c C-t` | `cargo test` |
| `C-c C-c C-l` | `cargo clippy` |
| `C-c C-f` | rustfmt buffer |

### Window

| Keys | Command |
|------|---------|
| `C-c w n/p/b/f` | Move focus | 
| `C-c w u` / `C-c w r` | Undo/redo layout |

## Structure

```
~/.config/emacs/
├── early-init.el             Package archives & init
├── init.el                   Bootstrap (16 lines)
└── modules/
    ├── redirect-file-config.el File redirection (backup, auto-save, recentf, savehist → var/)
    ├── helper-config.el       Utilities
    ├── completion-config.el  Completion system (vars, vertico, corfu, consult, cape)
    ├── editing-config.el     Editor defaults (revert, indent, so-long, etc.)
    ├── buffer-config.el      Buffers & windows (ibuffer, winner, windmove)
    ├── ui-config.el          Visual (font, bars, scrolling, keycast)
    ├── ide-config.el         LSP & syntax (eglot, treesit, editorconfig)
    ├── org-config.el         Org-mode & denote
    └── rust-config.el        Cargo keybindings
```

## License

[MIT](LICENSE)

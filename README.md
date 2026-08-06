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
| Minibuffer | `icomplete-vertical` + `completion-preview` — built-in vertical completion + inline preview |
| In-buffer | `corfu` + `cape` — popup completion + extra backends (dabbrev, file, keyword) |
| LSP | `eglot` — auto-starts rust-analyzer on `.rs` files, inlay hints, code actions |
| Cargo | `rust-mode` — `cargo build/check/test/clippy/fmt` keybindings |
| Editing | `electric-pair` + `repeat` + `so-long` — auto-pairs, repeatable keys, long-line protection |
| Shell | `exec-path-from-shell` + `eshell` — GUI env import, auto-scroll on input |
| Notes | `denote` + `org-mode` — structured note-taking, agenda, capture templates |
| Hints | `which-key` — popup keybinding discovery on prefix keys |
| UI | `keycast` + `pixel-scroll-precision` — mode-line key display, smooth scrolling |

## Keybindings

### Rust / Cargo

| Keys | Command |
|------|---------|
| `C-c C-c C-u` | `cargo build` |
| `C-c C-c C-k` | `cargo check` |
| `C-c C-c C-t` | `cargo test` |
| `C-c C-c C-l` | `cargo clippy` |
| `C-c C-f` | rustfmt buffer |

### LSP (Eglot)

| Keys | Command |
|------|---------|
| `C-c l a` | Code actions (quick fix) |
| `C-c l r` | Rename symbol |
| `C-c l f` | Format buffer |
| `C-c l .` | Find definition |
| `C-c l ,` | Find references |

### Org

| Keys | Command |
|------|---------|
| `C-c a` | Open agenda |
| `C-c c` | Quick capture |
| `C-c n n` | New denote note |
| `C-c n r` | Rename denote file |
| `C-c n l` | Insert denote link |
| `C-c n b` | Show backlinks |
| `C-c n g` | Grep notes directory |
| `C-c n d` | Dired notes directory |

**Capture workflow:** `C-c c t` → `inbox.org` (todos) · `C-c c n` → `capture-notes.org` (scratch notes) → promote to `C-c n n` (denote permanent note)

### Editing

| Keys | Command |
|------|---------|
| `C-x k` | Kill current buffer |
| `M-n / M-p` | Cycle completion preview |

### Window

| Keys | Command |
|------|---------|
| `C-c w n/p/b/f` | Move focus | 
| `C-c w u` / `C-c w r` | Undo/redo layout |

## Structure

```
~/.config/emacs/
├── early-init.el             Package archives & init
├── init.el                   Bootstrap (19 lines)
├── org/                       Org-mode files
│   ├── inbox.org              Capture target for todos (auto-created)
│   └── capture-notes.org      Capture target for scratch notes (auto-created)
├── notes/                     Denote knowledge base (auto-created)
├── var/                       Auto-generated data
│   ├── custom.el              Customize settings
│   ├── backup/                Edit backups (file~)
│   ├── auto-saves/            Auto-saves (#file#)
│   ├── auto-save-list/        Crash recovery
│   ├── recentf                Recent file list
│   ├── eln-cache/              Native-compiled cache
│   └── history                Minibuffer history
└── modules/
    ├── redirect-file-config.el File redirection (custom, backup, auto-save, recentf, savehist → var/)
    ├── helper-config.el       Utility commands
    ├── completion-config.el  Completion (corfu, cape, icomplete-vertical, completion-preview)
    ├── editing-config.el     Editor defaults (electric-pair, repeat, so-long, bidi, indentation)
    ├── buffer-config.el      Buffers & windows (ibuffer, winner, windmove, recentf, savehist)
    ├── ui-config.el          Visual (font, bars, pixel-scroll, keycast)
    ├── ide-config.el         LSP & tools (eglot, editorconfig, exec-path-from-shell)
    ├── which-key-config.el   Keybinding hint popups
    ├── org-config.el         Org-mode, denote, capture, agenda
    └── rust-config.el        Cargo keybindings for rust-ts-mode
```

## License

[MIT](LICENSE)

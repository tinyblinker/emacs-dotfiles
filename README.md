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

## Startup Optimization

The config uses several techniques to keep startup under one second:

| Technique | Where | What it does |
|-----------|-------|--------------|
| `package-quickstart` | `early-init.el` | Merge all package autoloads into one file so Emacs reads it in a single pass instead of scanning 50+ directories |
| GC throttle | `early-init.el` | Set `gc-cons-threshold` to max during init so Emacs never pauses for garbage collection while loading packages; restored after startup |
| File-handler cleanup | `early-init.el` | Temporarily nil `file-name-handler-alist` so every `load`/`require` doesn't check for remote paths, compressed files, etc. |
| Lazy loading | `modules/*.el` | Heavy packages (magit, org, org-roam, diff-hl, keycast) use `:defer t` or `:defer 1` — they only load when first used or after a 1-second idle timer |

Package load strategy:

```
eager (at startup)           lazy (on first use)         idle (1s after init)
─────────────────────        ─────────────────────       ─────────────────────
corfu  cape  which-key       org (open .org file)        magit
embark  consult  marginalia  org-roam (C-c n ...)        diff-hl
electric-pair  so-long       treemacs (C-c t)            keycast
exec-path-from-shell         rust-mode (open .rs file)
editorconfig  eglot
```

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
| Minibuffer | `consult` + `embark` + `marginalia` + `fido-vertical` + `completion-preview` — live-preview commands, context actions, rich annotations, built-in vertical completion + inline preview |
| In-buffer | `corfu` + `cape` — popup completion + extra backends (dabbrev, file, keyword) |
| LSP | `eglot` — auto-starts rust-analyzer on `.rs` files, inlay hints, code actions |
| Cargo | `rust-mode` — `cargo build/check/test/clippy/fmt` keybindings |
| Git | `magit` + `diff-hl` — porcelain Git interface + inline gutter indicators |
| Editing | `electric-pair` + `repeat` + `so-long` — auto-pairs, repeatable keys, long-line protection |
| Shell | `exec-path-from-shell` + `eshell` — GUI env import, auto-scroll on input |
| Notes | `org-roam` + `org-mode` — networked note-taking with backlinks, graph visualization, agenda, capture templates |
| Hints | `which-key` — popup keybinding discovery on prefix keys |
| Project | `project.el` + `treemacs` + `treemacs-magit` — project navigation sidebar, file search, git-synced tree |
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
| `C-c n n` | Find or create Org-roam note |
| `C-c n i` | Insert link to a note |
| `C-c n l` | Toggle backlinks sidebar |
| `C-c n g` | Show note graph |
| `C-c n t` | Add tag to note |
| `C-c n a` | Add alias to note |

**Capture workflow:** `C-c c t` → `inbox.org` (todos) · `C-c c n` → `capture-notes.org` (scratch notes) → promote to `C-c n n` (org-roam permanent note)

### Embark / Consult

| Keys | Command |
|------|---------|
| `C-.` | Act on target at point (context menu) |
| `C-;` | Run default action (open file, jump to symbol, etc.) |
| `C-h B` | Describe all active keybindings |
| `C-c h` | Search minibuffer history |
| `C-c m` | Search man pages |
| `C-c i` | Search Info manuals |
| `M-g g` | Go to line (w/ preview) |
| `M-g o` | Go to outline heading |
| `M-g i` | Go to symbol in buffer (imenu) |
| `M-g m` | Jump to mark (w/ preview) |
| `M-s g` | Grep project (w/ preview) |
| `M-s r` | Ripgrep project (w/ preview) |
| `M-s l` | Search lines in buffer (w/ preview) |
| `M-s d` | Find file by name (w/ preview) |
| `M-s f` | Find file with fd (w/ preview) |
| `M-y` | Enhanced yank-pop (w/ preview) |

### Editing

| Keys | Command |
|------|---------|
| `C-x k` | Kill current buffer |
| `M-n / M-p` | Cycle completion preview |

### Git (Magit)

| Keys | Command |
|------|---------|
| `C-x g` | Open magit status |
| `C-c g` | Git command menu (dispatch) |
| `C-c f` | File-level git commands |
| `s` | Stage change at point |
| `u` | Unstage change at point |
| `c c` | Commit staged changes |
| `C-c C-c` | Confirm commit (in message buffer) |
| `P p` | Push to remote |
| `M-n / M-p` | Jump to next/previous hunk |
| `C-c v d` | Show diff of hunk at point |

### Window

| Keys | Command |
|------|---------|
| `C-c w n/p/b/f` | Move focus | 
| `C-c w u` / `C-c w r` | Undo/redo layout |

### Project (project.el)

| Keys | Command |
|------|---------|
| `C-x p f` | Find file in project |
| `C-x p g` | Grep (search) in project |
| `C-x p p` | Switch to another project |
| `C-x p D` | Open project root in dired |
| `C-x p s` | Shell in project root |
| `C-x p e` | Eshell in project root |
| `C-x p c` | Compile in project root |

### Treemacs

| Keys | Command |
|------|---------|
| `C-c t` | Toggle treemacs sidebar |
| `TAB` / `RET` | Expand/collapse or visit node |
| `u` | Go to parent directory |
| `M-n` / `M-p` | Jump to next/previous sibling |
| `C-j` / `C-k` | Jump to next/previous project |
| `?` | Show keybinding helper hydra |
| `o` prefix | Open-file variants (split, ace-window, etc.) |
| `C-c C-p` prefix | Project add/remove/rename commands |
| `r` | Refresh the current tree |

## Structure

```
~/.config/emacs/
├── early-init.el             Package archives & init
├── init.el                   Bootstrap (24 lines)
├── org/                       Org-mode files
│   ├── inbox.org              Capture target for todos (auto-created)
│   └── capture-notes.org      Capture target for scratch notes (auto-created)
├── notes/                     Org-roam knowledge base (automatically indexed)
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
    ├── completion-config.el  Completion (corfu, cape, fido-vertical, completion-preview)
    ├── embark-consult-config.el Embark context actions, Consult preview commands, integration
    ├── marginalia-config.el  Rich completion annotations (file attributes, docstrings, etc.)
    ├── editing-config.el     Editor defaults (electric-pair, repeat, so-long, bidi, indentation)
    ├── buffer-config.el      Buffers & windows (ibuffer, winner, windmove, recentf, savehist)
    ├── ui-config.el          Visual (font, bars, pixel-scroll, keycast)
    ├── ide-config.el         LSP, projects, editorconfig (eglot, treemacs, project.el, editorconfig)
    ├── which-key-config.el   Keybinding hint popups
    ├── magit-config.el       Git porcelain interface
    ├── diff-hl-config.el     Inline git change indicators (gutter)
    ├── org-config.el         Org-mode, capture, agenda
    ├── org-roam-config.el    Networked note-taking, backlinks, graph
    └── rust-config.el        Cargo keybindings for rust-ts-mode
```

## License

[MIT](LICENSE)

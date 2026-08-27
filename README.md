<h1 align="center">
  <img src="https://www.gnu.org/software/emacs/images/emacs.png" alt="Emacs" width="32">
  emacs-dotfiles
</h1>

<p align="center">
  <a href="https://www.gnu.org/software/emacs/">
    <img src="https://img.shields.io/badge/Emacs-31.1-%237F5AB6?style=flat-square&logo=gnu-emacs&logoColor=white" alt="Emacs 31.1">
  </a>
  <a href="https://github.com/tinyblinker/emacs-dotfiles/stargazers">
    <img src="https://img.shields.io/github/stars/tinyblinker/emacs-dotfiles?style=flat-square&color=D0BCFF" alt="Stars">
  </a>
  <a href="https://github.com/tinyblinker/emacs-dotfiles/blob/main/LICENSE">
    <img src="https://img.shields.io/github/license/tinyblinker/emacs-dotfiles?style=flat-square&color=D0BCFF" alt="License">
  </a>
</p>

<p align="center"><sup>Minimal · Fast · Rust + Org</sup></p>

---

A lightweight Emacs 31.1 config for **Rust** (eglot + rust-analyzer) and **Org-mode** notes, pruned from [Crafted Emacs](https://github.com/SystemCrafters/crafted-emacs).

## Install

```bash
rustup component add rust-analyzer   # prerequisite
git clone https://github.com/tinyblinker/emacs-dotfiles.git ~/.config/emacs
```

Launch Emacs — packages install automatically on first run.

## Features

- **Completion** — `fido-vertical` in the minibuffer, `corfu` + `cape` popup in-buffer
- **LSP** — `eglot` auto-starts rust-analyzer on `.rs` files
- **Cargo** — build / check / test / clippy / fmt keybindings
- **Git** — `magit` + `diff-hl` gutter indicators
- **Notes** — `org-mode` + `org-roam` (+ mermaid diagrams, GFM export, LaTeX preview)
- **Shell** — `eshell` + `vterm` + `exec-path-from-shell`
- **UI** — JetBrainsMono NF, relative line numbers, smooth scrolling, clean frame, `modus-vivendi-tinted` theme

## Keybindings

| Prefix | Commands |
|--------|----------|
| `C-c C-c C-u/k/t/l` | cargo build / check / test / clippy |
| `C-c C-f` | rustfmt buffer |
| `C-c l` | eglot: `a` actions · `r` rename · `f` format · `.` def · `,` refs |
| `C-c a` / `C-c c` | org agenda / capture |
| `C-c n` | org-roam: `f` find · `i` insert · `l` backlinks · `g` graph |
| `C-c w` | windows: `n/p/b/f` move · `u/r` undo/redo |
| `C-c g` / `C-c f` | magit dispatch / file |
| `C-x p` | project: `f` find · `g` grep · `p` switch |

Capture: `C-c c t` → `org/inbox.org` · `C-c c n` → `org/capture-notes.org` → promote to a permanent note with `C-c n f`.

## Startup

Loads in under a second via `package-quickstart`, a GC throttle, and `file-name-handler-alist` cleanup in `early-init.el`; heavy packages (`org`, `org-roam`, `magit`, `diff-hl`, `keycast`, `vterm`) are deferred. Package archives use [USTC mirrors](https://mirrors.ustc.edu.cn/) for faster downloads.

## Structure

```
~/.config/emacs/
├── early-init.el     Packages, archives, quickstart, GC throttle
├── init.el           Loads the modules
├── modules/          Config, one file per concern
├── org/              Capture targets (inbox.org, capture-notes.org)
├── notes/            Org-roam knowledge base
└── var/              Auto-generated data (custom.el, org-roam.db, history, …)
```

## License

[MIT](LICENSE)

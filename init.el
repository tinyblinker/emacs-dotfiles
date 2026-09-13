;;; -*- lexical-binding: t -*-

;; Add modules directory to the load path so we can require config files
(add-to-list 'load-path (expand-file-name "modules" user-emacs-directory))
(require 'redirect-file-config)   ;; (should load first) redirect unwanted files

;; Utilities & appearance
(require 'helper-config)          ;; Utility commands (incl. CJK->ASCII)
(require 'ui-config)              ;; Font, line numbers, scrolling, UI chrome
(require 'keycast-config)         ;; Keycast in the tab bar
(require 'which-key-config)       ;; Keybinding hint popups

;; Editing basics
(require 'paren-config)           ;; show-paren + electric-pair
(require 'editing-config)         ;; Global editing defaults
(require 'auto-revert-config)     ;; Auto-revert buffers on disk change
(require 'so-long-config)         ;; Handle files with very long lines
(require 'repeat-config)          ;; Repeat commands with the last key
(require 'embrace-config)         ;; Surround-style add/change/delete pairs

;; Navigation
(require 'better-jumper-config)   ;; Jump list (C-o / C-M-o)
(require 'avy-config)             ;; flash-style jump to visible text

;; Completion & search (vertico + consult stack)
(require 'vertico-config)         ;; Vertical minibuffer completion
(require 'orderless-config)       ;; Flexible fuzzy matching
(require 'marginalia-config)      ;; Candidate annotations
(require 'embark-config)          ;; Contextual actions
(require 'consult-config)         ;; Search/navigation (telescope replacement)
(require 'consult-eglot-config)   ;; LSP workspace symbol search
(require 'symbol-overlay-config)  ;; Highlight same symbol at point
(require 'completion-config)      ;; Global completion defaults
(require 'corfu-config)           ;; In-buffer completion popup
(require 'cape-config)            ;; Completion-at-point backends

;; Buffers, windows & files
(require 'ibuffer-config)         ;; Filterable buffer list
(require 'recentf-config)         ;; Recently opened files
(require 'savehist-config)        ;; Persist history / kill ring
(require 'dired-config)           ;; Directory editor
(require 'window-config)          ;; winner + windmove + display rules
(require 'dirvish-config)         ;; yazi-style file manager
(require 'nerd-icons-config)      ;; Icon fonts

;; IDE / LSP
(require 'eglot-config)           ;; LSP client (rust-analyzer)
(require 'exec-path-from-shell-config) ;; Shell env for GUI/daemon
(require 'editorconfig-config)    ;; .editorconfig support
(require 'flymake-config)         ;; Diagnostics navigation
(require 'flymake-popon-config)   ;; Diagnostics popup near point
(require 'rust-config)            ;; Cargo keybindings for rust-ts-mode

;; Git & shell
(require 'magit-config)           ;; Git integration
(require 'diff-hl-config)         ;; Inline git change indicators
(require 'vterm-config)           ;; Terminal emulator

;; Org-mode
(require 'org-config)             ;; Org-mode, capture, agenda
(require 'ob-mermaid-config)      ;; Mermaid diagrams in org-babel
(require 'ox-gfm-config)          ;; GFM export backend
(require 'org-roam-config)        ;; Networked notes, backlinks, graph

;; Apply the dark high-contrast modus-vivendi theme
(load-theme 'modus-vivendi-tinted t)

;; Warm the native-comp cache in the background so that startup (and the
;; first load of any deferred package) doesn't block on synchronous JIT
;; compilation.  Idempotent: already-compiled files are skipped.
(when (native-comp-available-p)
  (native-compile-async (expand-file-name "elpa" user-emacs-directory)
                        'recursively))

;;; -*- lexical-binding: t -*-

;; Put modules dir on load-path
(add-to-list 'load-path (expand-file-name "modules" user-emacs-directory))
(require 'redirect-file-config)   ;; redirect unwanted files


;; Buffers & files
(require 'ibuffer-config)         ;; buffer list
(require 'recentf-config)         ;; recent files
(require 'savehist-config)        ;; history / kill ring
(require 'dired-config)           ;; directory editor
(require 'window-config)          ;; windows
(require 'dirvish-config)         ;; file manager
(require 'nerd-icons-config)      ;; icons

;; LSP
(require 'eglot-config)           ;; LSP client
(require 'exec-path-from-shell-config) ;; shell env
(require 'editorconfig-config)    ;; .editorconfig
(require 'flymake-config)         ;; diagnostics navigation
(require 'flymake-popon-config)   ;; diagnostics popup
(require 'rust-config)            ;; cargo bindings

;; Git & shell
(require 'magit-config)           ;; git
(require 'diff-hl-config)         ;; git indicators
(require 'vterm-config)           ;; terminal

;; Org
(require 'org-config)             ;; org-mode
(require 'ob-mermaid-config)      ;; mermaid in babel
(require 'ox-gfm-config)          ;; GFM export
(require 'org-roam-config)        ;; roam notes

;; Dark theme
(load-theme 'modus-vivendi-tinted t)

;; Pre-warm native-comp cache in background
(when (native-comp-available-p)
  (native-compile-async (expand-file-name "elpa" user-emacs-directory)
                        'recursively))

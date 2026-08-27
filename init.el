;;; -*- lexical-binding: t -*-

;; Add modules directory to the load path so we can require config files
(add-to-list 'load-path (expand-file-name "modules" user-emacs-directory))
(require 'redirect-file-config)   ;; (should load first)set vars to redirect unwanted confusing massing files


;; Load all configuration modules
(require 'helper-config)          ;; Utility commands
(require 'ui-config)              ;; Font, scrolling, UI chrome
(require 'which-key-config)       ;; Keybinding hint popups
(require 'editing-config)         ;; Global editing defaults
(require 'buffer-config)          ;; Buffer, window, dired, history
(require 'completion-config)      ;; Corfu, cape, fido-vertical
(require 'ide-config)             ;; Eglot LSP, editorconfig, shell env
(require 'org-config)             ;; Org-mode, capture, agenda
(require 'org-roam-config)        ;; Networked note-taking, backlinks, graph visualization
(require 'rust-config)            ;; Cargo keybindings for rust-ts-mode
(require 'magit-config)           ;; Git integration with Magit
(require 'diff-hl-config)         ;; Inline git change indicators
(require 'vterm-config)           ;; Terminal emulator


;; Apply the dark high-contrast modus-vivendi theme
(load-theme 'modus-vivendi-tinted t)

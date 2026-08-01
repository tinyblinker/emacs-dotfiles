;; let the auto-generated codes being sepearated by putting into costom.el
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (and custom-file
           (file-exists-p custom-file))
  (load custom-file nil :nomessage))

;; customize UI settings
(customize-set-variable 'inhibit-startup-screen t)
(customize-set-variable 'global-display-line-numbers-mode 1)
(customize-set-variable 'menu-bar-mode nil)
(customize-set-variable 'tool-bar-mode nil)
(customize-set-variable 'initial-scratch-message nil)
(customize-set-variable 'blink-cursor-mode nil)
(customize-set-variable 'scroll-bar-mode nil)
(customize-set-variable 'scroll-step 1)
(customize-set-variable 'scroll-margin 5)

;; Bootstrap crafted-emacs in init.el
(load "~/.config/emacs/custom-modules/crafted-init-config.el")

;; Load crafted defaults
(require 'crafted-defaults-config)

;; Add package definition for completion packages
;; to 'package-selected-packages
(require 'crafted-completion-packages)
(require 'crafted-org-packages)
(require 'crafted-ide-packages)
(require 'crafted-org-packages)
(require 'crafted-lisp-packages)
(require 'crafted-screencast-packages)
(require 'crafted-ui-packages)
(require 'crafted-workspaces-packages)

;; Manually select additional packages
(add-to-list 'package-selected-packages 'rust-mode)
(add-to-list 'package-selected-packages 'ef-themes)

;; Install the packages listed in 'package-selected-packages list
(package-install-selected-packages :noconfirm)

;; Load configuration for the completion module
(require 'crafted-completion-config)
(require 'crafted-org-config)
(require 'crafted-ide-config)
(require 'crafted-defaults-config)
(require 'crafted-lisp-config)
(require 'cradted-screencast-config)
(require 'crafted-ui-config)
(require 'crafted-workspaces-config)
(crafted-ide-eglot-auto-ensure-all)
(crafted-ide-configure-tree-sitter)

;; Rust keybindings
(with-eval-after-load 'rust-ts-mode
  (require 'rust-mode)
  (keymap-set rust-ts-mode-map "C-c C-c C-u" #'rust-compile)
  (keymap-set rust-ts-mode-map "C-c C-c C-k" #'rust-check)
  (keymap-set rust-ts-mode-map "C-c C-c C-t" #'rust-test)
  (keymap-set rust-ts-mode-map "C-c C-c C-l" #'rust-run-clippy)
  (keymap-set rust-ts-mode-map "C-c C-f" #'rust-format-buffer))

;; Theme
(load-theme 'ef-summer t)

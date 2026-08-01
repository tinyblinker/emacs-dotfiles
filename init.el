(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (and custom-file
           (file-exists-p custom-file))
  (load custom-file nil :nomessage))

(customize-set-variable 'inhibit-startup-screen t)
(customize-set-variable 'global-display-line-numbers-mode 1)
(customize-set-variable 'menu-bar-mode nil)
(customize-set-variable 'tool-bar-mode nil)
(customize-set-variable 'initial-scratch-message nil)
(customize-set-variable 'blink-cursor-mode nil)
(customize-set-variable 'scroll-bar-mode nil)
(customize-set-variable 'scroll-step 1)
(customize-set-variable 'scroll-margin 5)

(load "~/.config/emacs/custom-modules/crafted-init-config.el")

(require 'crafted-defaults-config)

(require 'crafted-completion-packages)
(require 'crafted-org-packages)
(require 'crafted-ide-packages)
(require 'crafted-screencast-packages)

(add-to-list 'package-selected-packages 'rust-mode)

(package-install-selected-packages :noconfirm)

(require 'crafted-completion-config)
(require 'crafted-org-config)
(require 'crafted-ide-config)
(require 'crafted-defaults-config)
(require 'cradted-screencast-config)

(with-eval-after-load 'rust-ts-mode
  (require 'rust-mode)
  (keymap-set rust-ts-mode-map "C-c C-c C-u" #'rust-compile)
  (keymap-set rust-ts-mode-map "C-c C-c C-k" #'rust-check)
  (keymap-set rust-ts-mode-map "C-c C-c C-t" #'rust-test)
  (keymap-set rust-ts-mode-map "C-c C-c C-l" #'rust-run-clippy)
  (keymap-set rust-ts-mode-map "C-c C-f" #'rust-format-buffer))

(load-theme 'ef-summer t)

;;; -*- lexical-binding: t -*-

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

(defun add-lexical-binding-to-file ()
  (interactive)
  (save-excursion
    (goto-char (point-min))
    (if (looking-at-p ".*lexical-binding.*")
        (message "already had the 'lexical-binding'")
      (insert ";;; -*- lexical-binding: t -*-\n\n")
      (message "added successfully"))))

(load "~/.config/emacs/modules/crafted-init-config.el")

(require 'crafted-defaults-config)
(require 'crafted-completion-config)
(require 'crafted-org-config)
(require 'crafted-ide-config)
(require 'crafted-defaults-config)
(require 'crafted-screencast-config)

(use-package rust-mode
  :ensure t
  :after rust-ts-mode
  :bind (:map rust-ts-mode-map
              ("C-c C-c C-u" . #'rust-compile)
              ("C-c C-c C-k" . #'rust-check)
              ("C-c C-c C-t" . #'rust-test)
              ("C-c C-c C-l" . #'rust-run-clippy)
              ("C-c C-f" . #'rust-format-buffer)))


;;; -*- lexical-binding: t -*-

;; set "custom.el"
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (and custom-file
           (file-exists-p custom-file))
  (load custom-file nil :nomessage))

(global-display-line-numbers-mode 1)
(menu-bar-mode -1)
(tool-bar-mode -1)
(blink-cursor-mode -1)
(scroll-bar-mode -1)
(customize-set-variable 'scroll-step 1)
(customize-set-variable 'initial-scratch-message nil)
(customize-set-variable 'inhibit-startup-screen t)

;; helper function
(defun add-lexical-binding-to-file ()
  (interactive)
  (save-excursion
    (goto-char (point-min))
    (if (looking-at-p ".*lexical-binding.*")
        (message "already had the 'lexical-binding'")
      (insert ";;; -*- lexical-binding: t -*-\n\n")
      (message "added successfully"))))

(add-to-list 'load-path (expand-file-name "modules" user-emacs-directory))

(require 'crafted-defaults-config)
(require 'crafted-completion-config)
(require 'crafted-org-config)
(require 'crafted-ide-config)
(require 'crafted-screencast-config)

(load-theme 'modus-vivendi t)

(use-package rust-mode
  :ensure t
  :after rust-ts-mode
  :bind (:map rust-ts-mode-map
              ("C-c C-c C-u" . #'rust-compile)
              ("C-c C-c C-k" . #'rust-check)
              ("C-c C-c C-t" . #'rust-test)
              ("C-c C-c C-l" . #'rust-run-clippy)
              ("C-c C-f" . #'rust-format-buffer)))


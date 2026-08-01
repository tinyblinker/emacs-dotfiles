;;; crafted-ui-config.el --- Crafted UI Config -*- lexical-binding: t; -*-

;; Copyright (C) 2024
;; SPDX-License-Identifier: MIT

;; Author: System Crafters Community

;;; Code:

(defgroup crafted-ui '()
  "UI configuration for Crafted Emacs"
  :tag "Crafted UI"
  :group 'crafted)

(defcustom crafted-ui-line-numbers-enabled-modes
  '(conf-mode prog-mode)
  "Modes which should display line numbers."
  :type 'list
  :group 'crafted-ui)

(defcustom crafted-ui-line-numbers-disabled-modes
  '(org-mode)
  "Modes which should not display line numbers.

Modes derived from the modes defined in
`crafted-ui-line-number-enabled-modes', but should not display line numbers."
  :type 'list
  :group 'crafted-ui)

(when (require 'helpful nil :noerror)
  (keymap-set helpful-mode-map "<remap> <revert-buffer>" #'helpful-update)
  (keymap-global-set "<remap> <describe-command>"        #'helpful-command)
  (keymap-global-set "<remap> <describe-function>"       #'helpful-callable)
  (keymap-global-set "<remap> <describe-key>"            #'helpful-key)
  (keymap-global-set "<remap> <describe-symbol>"         #'helpful-symbol)
  (keymap-global-set "<remap> <describe-variable>"       #'helpful-variable)
  (keymap-global-set "C-h F"                             #'helpful-function))

(keymap-global-set "C-h K" #'describe-keymap)

(defun crafted-ui--enable-line-numbers-mode ()
  "Turn on line numbers mode.

Used as hook for modes which should display line numbers."
  (display-line-numbers-mode 1))

(defun crafted-ui--disable-line-numbers-mode ()
  "Turn off line numbers mode.

Used as hook for modes which should not display line numebrs."
  (display-line-numbers-mode -1))

(defun crafted-ui--update-line-numbers-display ()
  "Update configuration for line numbers display."
  (if crafted-ui-display-line-numbers
      (progn
        (dolist (mode crafted-ui-line-numbers-enabled-modes)
          (add-hook (intern (format "%s-hook" mode))
                    #'crafted-ui--enable-line-numbers-mode))
        (dolist (mode crafted-ui-line-numbers-disabled-modes)
          (add-hook (intern (format "%s-hook" mode))
                    #'crafted-ui--disable-line-numbers-mode))
        (setq-default
         display-line-numbers-grow-only t
         display-line-numbers-type t
         display-line-numbers-width 2))
    (progn
      (dolist (mode crafted-ui-line-numbers-enabled-modes)
        (remove-hook (intern (format "%s-hook" mode))
                     #'crafted-ui--enable-line-numbers-mode))
      (dolist (mode crafted-ui-line-numbers-disabled-modes)
        (remove-hook (intern (format "%s-hook" mode))
                     #'crafted-ui--disable-line-numbers-mode)))))

(defcustom crafted-ui-display-line-numbers nil
  "Whether line numbers should be enabled."
  :type 'boolean
  :group 'crafted-ui
  :set (lambda (sym val)
         (set-default sym val)
         (crafted-ui--update-line-numbers-display)))

(when (require 'elisp-demos nil :noerror)
  (advice-add 'helpful-update :after #'elisp-demos-advice-helpful-update))

(defun pulse-line (&rest _)
  "Pulse the current line."
  (pulse-momentary-highlight-one-line (point)))

(dolist (command '(scroll-up-command
                   scroll-down-command
                   recenter-top-bottom
                   other-window))
  (advice-add command :after #'pulse-line))

(when (require 'breadcrumb nil :noerror)
  (breadcrumb-mode))

(provide 'crafted-ui-config)
;;; crafted-ui-config.el ends here

;;;; crafted-init-config.el --- Crafted Emacs initial configuration  -*- lexical-binding: t; -*-

;; Overview
;; Perform some initialization for use by Crafted Emacs modules among
;; other things.

;; Find the cloned `crafted-emacs' and use that as the value for the
;; `crafted-emacs-home' value which is needed by a few modules,

;;; A top level group containing subgroups like `crafted-init' -
;;; - See `M-x customize-group RET crafted'
(defgroup crafted '()
  "Customization options for Crafted Emacs."
  :tag "Crafted")

;;; Customization variables - See `M-x customize-group RET crafted-init'
(defgroup crafted-init '()
  "Customizations for Crafted Emacs - Initialization."
  :tag "Crafted Init"
  :group 'crafted)

;; Option :`crafted-init-auto-save-customized'
(defcustom crafted-init-auto-save-customized t
  "Save customized variables automatically every session."
  :type 'boolean
  :group 'crafted-init)

;; Option :`crafted-init-auto-save-selected-packages'
(defcustom crafted-init-auto-save-selected-packages t
  "Save the list of selected packages automatically every session."
  :type 'boolean
  :group 'crafted-init)

(require 'project)

;; Options: mannually set it
(customize-set-variable 'load-prefer-newer t)

;; Create the variable if needed
(if (boundp 'crafted-emacs-home)
    (message "crafted-emacs-home value set by user: %s" crafted-emacs-home)
  (defvar crafted-emacs-home nil
    "Defines where the Crafted Emacs project was cloned to.

This is set when loading the crafted-init-config.el module during
initialization.  Alternatively, it can be set by the user
explicitly."))

;; Only set the `crafted-emacs-home' variable when not exists
(when (null crafted-emacs-home)
  (setq crafted-emacs-home
        (expand-file-name
         (vc-find-root load-file-name "modules"))))

;; If still no `crafted-emacs-home' value, throw errors
(unless crafted-emacs-home
  (error "%s\n%s"
         "The value for crafted-emacs-home is not set"
         "Please set this value to the location where crafted-emacs is installed"))

;; update `load-path'(`custom-modules/' override 'modules/')
(let ((modules (expand-file-name "./modules/" crafted-emacs-home)))
  (when (file-directory-p modules)
    (message "adding modules to load-path: %s" modules)
    (add-to-list 'load-path modules)))
(let ((custom-modules (expand-file-name "custom-modules" user-emacs-directory)))
  (when (file-directory-p custom-modules)
    (message "adding custom-modules to load-path: %s" custom-modules)
    (add-to-list 'load-path custom-modules)))

;; When writing crafted-modules, insert header from skeleton
(auto-insert-mode)
(with-eval-after-load "autoinsert" 
  (defun ignore-auto-insert-for-custom (orig-auto-insert &rest args)
    "Apply ORIG-AUTO-INSERT only when the file is not the
         `custom-file' to avoid confusion when that file doesn't exist on
         startup."
    (if (and custom-file buffer-file-name
             (string-match (file-name-nondirectory custom-file) buffer-file-name))
        (message "Skipping auto-insert for %s" custom-file)
      (apply orig-auto-insert args)))
  (advice-add 'auto-insert :around #'ignore-auto-insert-for-custom)
  (define-auto-insert
    (cons (expand-file-name "modules/crafted-.*\\.el" crafted-emacs-home)
          "Crafted Emacs Lisp Skeleton")
    '("Crafted Emacs Module Description: "
      ";;;; " (file-name-nondirectory (buffer-file-name)) " --- " str
         (make-string (max 2 (- 80 (current-column) 27)) ?\s)
         "-*- lexical-binding: t; -*-" '(setq lexical-binding t)
         "

;; Copyright (C) " (format-time-string "%Y") "
;; SPDX-License-Identifier: MIT

;; Author: System Crafters Community

;;; Commentary:

;; " _ "

;;; Code:

(provide '"
         (file-name-base (buffer-file-name))
         ")
;;; " (file-name-nondirectory (buffer-file-name)) " ends here\n")))

;; Add the Crafted Emacs documentation to the info nodes
(let ((crafted-info-dir (expand-file-name "docs/dir" crafted-emacs-home)))
  (when (file-exists-p crafted-info-dir)
    (require 'info)
    (info-initialize)
    (push (file-name-directory crafted-info-dir) Info-directory-list)))

(defun crafted-save-customized ()
  "Save and reload the customizations made during Emacs initialization.

Due to the way Emacs Customization works - or seems to - and this
bug: https://debbugs.gnu.org/cgi/bugreport.cgi?bug=21355, we need
to save all customizations made during Emacs startup and then
reload the custom-file.  This sets (or should set) all customized
values to the \"SET and saved.\" state and (hopefully) avoid the
bug above.  If the user never set a value for `custom-file' then
we can't reload the file."
  (customize-save-customized)
  ;; only load the `custom-file' if it is not `nil'.
  (when custom-file
    (load custom-file :noerror)))

(defun crafted-save-selected-packages ()
  "Save the list of selected packages.

This saves the state of the variable `package-selected-packages` to the
custom file after initialization."
  (package--save-selected-packages package-selected-packages))

;; Save all customizations to `custom-file', unless the user opted out.
(when crafted-init-auto-save-customized
  (add-hook 'after-init-hook #'crafted-save-customized))
(when crafted-init-auto-save-selected-packages
  (add-hook 'after-init-hook #'crafted-save-selected-packages))

(provide 'crafted-init-config)
;;; crafted-init-config.el ends here

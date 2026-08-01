;;;; crafted-init-config.el --- Crafted Emacs initial configuration  -*- lexical-binding: t; -*-

;; Copyright (C) 2024
;; SPDX-License-Identifier: MIT

;; Author: System Crafters Community

;;; Code:

(defgroup crafted '()
  "Customization options for Crafted Emacs."
  :tag "Crafted")

(defgroup crafted-init '()
  "Customizations for Crafted Emacs - Initialization."
  :tag "Crafted Init"
  :group 'crafted)

(defcustom crafted-init-auto-save-customized t
  "Save customized variables automatically every session."
  :type 'boolean
  :group 'crafted-init)

(defcustom crafted-init-auto-save-selected-packages t
  "Save the list of selected packages automatically every session."
  :type 'boolean
  :group 'crafted-init)

(when (version< emacs-version "29")
  (unless (require 'compat nil :noerror)
    (package-install 'compat)))

(require 'project)

(customize-set-variable 'load-prefer-newer t)

(if (boundp 'crafted-emacs-home)
    (message "crafted-emacs-home value set by user: %s" crafted-emacs-home)
  (defvar crafted-emacs-home nil
    "Defines where the Crafted Emacs project was cloned to.

This is set when loading the crafted-init-config.el module during
initialization.  Alternatively, it can be set by the user
explicitly."))

(when (null crafted-emacs-home)
  (setq crafted-emacs-home
        (expand-file-name
         (vc-find-root load-file-name "modules"))))

(unless crafted-emacs-home
  (error "%s\n%s"
         "The value for crafted-emacs-home is not set"
         "Please set this value to the location where crafted-emacs is installed"))

(let ((modules (expand-file-name "./modules/" crafted-emacs-home)))
  (when (file-directory-p modules)
    (message "adding modules to load-path: %s" modules)
    (add-to-list 'load-path modules)))

(let ((custom-modules (expand-file-name "custom-modules" user-emacs-directory)))
  (when (file-directory-p custom-modules)
    (message "adding custom-modules to load-path: %s" custom-modules)
    (add-to-list 'load-path custom-modules)))

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
  (when custom-file
    (load custom-file :noerror)))

(defun crafted-save-selected-packages ()
  "Save the list of selected packages.

This saves the state of the variable `package-selected-packages` to the
custom file after initialization."
  (package--save-selected-packages package-selected-packages))

(when crafted-init-auto-save-customized
  (add-hook 'after-init-hook #'crafted-save-customized))
(when crafted-init-auto-save-selected-packages
  (add-hook 'after-init-hook #'crafted-save-selected-packages))

(provide 'crafted-init-config)
;;; crafted-init-config.el ends here

;;; -*- lexical-binding: t -*-

;; define some groups 
(defgroup crafted '()
  "Customization options for Crafted Emacs."
  :tag "Crafted")
(defgroup crafted-init '()
  "Customizations for Crafted Emacs - Initialization."
  :tag "Crafted Init"
  :group 'crafted)

;; define user-customized variables
(defcustom crafted-init-auto-save-customized t
  "Save customized variables automatically every session."
  :type 'boolean
  :group 'crafted-init)
(defcustom crafted-init-auto-save-selected-packages t
  "Save the list of selected packages automatically every session."
  :type 'boolean
  :group 'crafted-init)

;; autoset the "crafted-emacs-home"(user can overwrite it)
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

;; add modules to "load-path" based on "crafted-emacs-home"
(let ((modules (expand-file-name "./modules/" crafted-emacs-home)))
  (when (file-directory-p modules)
    (message "adding modules to load-path: %s" modules)
    (add-to-list 'load-path modules)))

;; helper function: (hooks: Emacs init) save and reload the customizations 
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

;; helper function: save "packages-selected-packages"
(defun crafted-save-selected-packages ()
  "Save the list of selected packages.

This saves the state of the variable `package-selected-packages` to the
custom file after initialization."
  (package--save-selected-packages package-selected-packages))

;; add hooks
(when crafted-init-auto-save-customized
  (add-hook 'after-init-hook #'crafted-save-customized))
(when crafted-init-auto-save-selected-packages
  (add-hook 'after-init-hook #'crafted-save-selected-packages))

;; provide the feature
(provide 'crafted-init-config)
;;; crafted-init-config.el ends here

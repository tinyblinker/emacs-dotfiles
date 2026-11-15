;;; -*- lexical-binding: t -*-

;; Put modules dir on load-path
(add-to-list 'load-path (expand-file-name "modules" user-emacs-directory))

;; modules to be loaded
(defvar my-modules
  '(redirect-file-config
    completion-config
    editor-config
    langs-config
    langs-mode-config
    misc-config
    myhelpers-config
    navigation-config
    org-config
    ui-config
    vcs-config)
  "my modules to be loaded")

;; Load all modules in Order
(dolist (module my-modules)
  (require module))

;; a function to check all modules are
;; Explicit loaded by the exprs above
(defun my/if-all-modules-are-load ()
  (interactive)
  (if (dolist (file (directory-files
                     (expand-file-name "modules" user-emacs-directory t "\\.el\\")))
        (dolist ()))))
(my/if-all-modules-are-load)
;; Dark theme
(load-theme 'modus-vivendi-tinted t)

;; Pre-warm native-comp cache in background
(when (native-comp-available-p)
  (native-compile-async (expand-file-name "elpa" user-emacs-directory)
                        'recursively))

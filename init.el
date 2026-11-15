;;; -*- lexical-binding: t -*-

;; Put modules dir on load-path
(add-to-list 'load-path (expand-file-name "modules" user-emacs-directory))

;; modules to be loaded
(defvar loaded-modules-list
  '(redirect-file-config
    completion-config
    langs-config
    langs-mode-config
    misc-config
    myhelpers-config
    navigation-config
    org-config
    terminal-config
    basic-config
    vcs-config)
  "my modules to be loaded")

;; Load all modules in Order
(dolist (module loaded-modules-list)
  (require module))

;; a function to check all modules are
;; Explicit loaded by the exprs above
(defun my/if-all-modules-are-loaded ()
  (interactive)
  (let* ((my-unload-modules nil)
         (filename-list (directory-files
                         (expand-file-name
                          "modules"
                          user-emacs-directory)
                         nil
                         "\\.el\\'"))
         (my-modules-list (mapcar #'file-name-base filename-list)))
    (progn
      (dolist (my-module my-modules-list)
        (unless (member (intern my-module) loaded-modules-list)
          (push my-module my-unload-modules))))
    (if my-unload-modules
        (user-error "'init.el' Modules Missing:%s" my-unload-modules))
    (message "'init.el' All Modules loaded")))
(my/if-all-modules-are-loaded)

;; Dark theme
(load-theme 'modus-vivendi-tinted t)

;; Pre-warm native-comp cache in background
(when (native-comp-available-p)
  (native-compile-async (expand-file-name "elpa" user-emacs-directory)
                        'recursively))

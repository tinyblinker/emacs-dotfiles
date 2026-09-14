;;; -*- lexical-binding: t -*-

;; Put modules dir on load-path
(add-to-list 'load-path (expand-file-name "modules" user-emacs-directory))
(require 'redirect-file-config)   ;; redirect unwanted files

;; Load all other modules
(dolist (file (directory-files (expand-file-name "modules" user-emacs-directory)
                               t "\\.el\\'"))
  (unless (equal (file-name-base file) "redirect-file-config")
    (load file nil 'nomessage)))

;; Dark theme
(load-theme 'modus-vivendi-tinted t)

;; Pre-warm native-comp cache in background
(when (native-comp-available-p)
  (native-compile-async (expand-file-name "elpa" user-emacs-directory)
                        'recursively))

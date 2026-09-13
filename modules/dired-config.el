;;; -*- lexical-binding: t -*-

;; Dired: directory editor (overridden by dirvish at runtime)
(use-package dired
  :custom
  (dired-dwim-target t)           ;; Guess copy/move target from the other window
  (dired-auto-revert-buffer t))   ;; Refresh listing when files change externally

(provide 'dired-config)
;;; dired-config.el ends here

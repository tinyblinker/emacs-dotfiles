;;; -*- lexical-binding: t -*-

;; ox-gfm: GitHub Flavored Markdown export backend for org-mode
(use-package ox-gfm
  :ensure t
  :config
  (eval-after-load "org"
    '(require 'ox-gfm nil t)))

(provide 'ox-gfm-config)
;;; ox-gfm-config.el ends here

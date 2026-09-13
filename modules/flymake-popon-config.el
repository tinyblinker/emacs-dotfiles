;;; -*- lexical-binding: t -*-

;; Flymake-popon: show diagnostics in a popup near point
(use-package flymake-popon
  :ensure t
  :hook (flymake-mode . flymake-popon-mode))

(provide 'flymake-popon-config)
;;; flymake-popon-config.el ends here

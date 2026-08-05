;;; -*- lexical-binding: t -*-

;; set "keycast" for the real-time display of the kdb
(use-package keycast
  :ensure t
  :custom
  (keycast-mode-line-mode-remove-tail-elements nil)
  (keycast-mode-line-mode-remove-insert-after 'mode-line-misc-info)
  :config
  (keycast-mode-line-mode))

;; add necessaey features
(provide 'crafted-screencast-config)
;;; crafted-screencast.el ends here

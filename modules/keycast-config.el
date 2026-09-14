;;; -*- lexical-binding: t -*-

;; Show pressed keys in the mode line
(use-package keycast
  :ensure t
  :defer 1               ; deferred 1s
  :config
  (keycast-mode-line-mode 1))

(provide 'keycast-config)
;;; keycast-config.el ends here

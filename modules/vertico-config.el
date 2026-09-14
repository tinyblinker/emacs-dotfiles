;;; -*- lexical-binding: t -*-

;; Vertical minibuffer completion
(use-package vertico
  :ensure t
  :defer 1
  :custom
  (vertico-cycle t)  ;; wrap around
  :config
  (vertico-mode 1))

(provide 'vertico-config)
;;; vertico-config.el ends here

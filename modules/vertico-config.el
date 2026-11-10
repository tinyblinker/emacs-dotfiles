;;; -*- lexical-binding: t -*-

;; Vertical minibuffer completion
(use-package vertico
  :ensure t
  :demand t          ;; load during init: deferring breaks the first M-x
  :custom
  (vertico-cycle t)  ;; wrap around
  :config
  (vertico-mode 1))

(provide 'vertico-config)
;;; vertico-config.el ends here

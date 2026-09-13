;;; -*- lexical-binding: t -*-

;; Vertico: vertical minibuffer completion UI (replaces fido-vertical)
(use-package vertico
  :ensure t
  :init
  (vertico-mode 1)
  :custom
  (vertico-cycle t))  ;; wrap around at list boundaries

(provide 'vertico-config)
;;; vertico-config.el ends here

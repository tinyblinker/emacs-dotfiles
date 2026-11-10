;;; -*- lexical-binding: t -*-

;; Annotate candidates
(use-package marginalia
  :ensure t
  :demand t          ;; load during init so the first M-x gets annotations
  :config
  (marginalia-mode 1))

(provide 'marginalia-config)
;;; marginalia-config.el ends here

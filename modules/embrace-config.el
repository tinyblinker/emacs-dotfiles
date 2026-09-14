;;; -*- lexical-binding: t -*-

;; Surround pairs
(use-package embrace
  :ensure t
  :bind (("C-c e a" . embrace-add)     ;; add
         ("C-c e c" . embrace-change)  ;; change
         ("C-c e d" . embrace-delete))) ;; delete

(provide 'embrace-config)
;;; embrace-config.el ends here

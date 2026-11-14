;;; -*- lexical-binding: t -*-

(use-package eglot
  :custom
  (eglot-autoshutdown t) ;; autoshutdown
  :hook
  ;; inlay hints after connect
  ((eglot-managed-mode . eglot-inlay-hints-mode))
  :bind (:map eglot-mode-map
              ("C-c l a" . eglot-code-actions)
              ("C-c l r" . eglot-rename)
              ("C-c l f" . eglot-format-buffer)
              ("C-c l ." . xref-find-definitions)
              ("C-c l ," . xref-find-references)))

(use-package flymake
  :bind (("C-c ! n" . flymake-goto-next-error)
         ("C-c ! p" . flymake-goto-prev-error)))

(use-package flymake-popon
  :ensure t
  :hook (flymake-mode . flymake-popon-mode))

(provide 'langs-config)
;;; langs-config.el ends here

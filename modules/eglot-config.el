;;; -*- lexical-binding: t -*-

;; LSP client
(use-package eglot
  :custom
  (eglot-autoshutdown t) ;; autoshutdown
  :hook
  ((rust-ts-mode . eglot-ensure)
   (rust-mode . eglot-ensure)
   ;; inlay hints after connect
   (eglot-managed-mode . eglot-inlay-hints-mode))
  :bind (:map eglot-mode-map
              ("C-c l a" . eglot-code-actions)
              ("C-c l r" . eglot-rename)
              ("C-c l f" . eglot-format-buffer)
              ("C-c l ." . xref-find-definitions)
              ("C-c l ," . xref-find-references)))

(provide 'eglot-config)
;;; eglot-config.el ends here

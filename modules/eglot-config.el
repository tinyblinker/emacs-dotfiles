;;; -*- lexical-binding: t -*-

;; Eglot: LSP client (rust-analyzer auto-detected for rust-ts-mode/rust-mode)
(use-package eglot
  :custom
  (eglot-autoshutdown t) ;; shut down server when last managed buffer closes
  :hook
  ((rust-ts-mode . eglot-ensure)
   (rust-ts-mode . eglot-inlay-hints-mode)
   (rust-mode . eglot-ensure))
  :bind (:map eglot-mode-map
              ("C-c l a" . eglot-code-actions)
              ("C-c l r" . eglot-rename)
              ("C-c l f" . eglot-format-buffer)
              ("C-c l ." . xref-find-definitions)
              ("C-c l ," . xref-find-references)))

(provide 'eglot-config)
;;; eglot-config.el ends here

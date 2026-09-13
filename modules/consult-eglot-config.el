;;; -*- lexical-binding: t -*-

;; Consult-eglot: search LSP workspace symbols through consult
;; (simulates neovim's telescope + lsp symbols linkage)
(use-package consult-eglot
  :ensure t
  :after (consult eglot)
  :bind (:map eglot-mode-map
              ("C-c l s" . consult-eglot-symbols)))

(provide 'consult-eglot-config)
;;; consult-eglot-config.el ends here

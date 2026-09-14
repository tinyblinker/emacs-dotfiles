;;; -*- lexical-binding: t -*-

;; LSP workspace symbols
(use-package consult-eglot
  :ensure t
  :after (consult eglot)
  :bind (:map eglot-mode-map
              ("C-c l s" . consult-eglot-symbols)))

(provide 'consult-eglot-config)
;;; consult-eglot-config.el ends here

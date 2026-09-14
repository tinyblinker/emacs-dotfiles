;;; -*- lexical-binding: t -*-

;; Persist history
(use-package savehist
  :custom
  (savehist-additional-variables '(kill-ring register-alist search-ring regexp-search-ring))
  :config (savehist-mode 1))

(provide 'savehist-config)
;;; savehist-config.el ends here

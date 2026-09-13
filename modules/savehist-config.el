;;; -*- lexical-binding: t -*-

;; Savehist: persist minibuffer history, kill ring, and search rings
(use-package savehist
  :custom
  (savehist-additional-variables '(kill-ring register-alist search-ring regexp-search-ring))
  :config (savehist-mode 1))

(provide 'savehist-config)
;;; savehist-config.el ends here

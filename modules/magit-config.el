;;; -*- lexical-binding: t -*-

(use-package magit
  :ensure t
  :custom
  (magit-define-global-key-bindings 'recommended)  ; C-c g = dispatch, C-c f = file
  (magit-save-repository-buffers 'dontask)          ; auto-save before git ops
  :config
  (magit-auto-revert-mode 1))                       ; auto-revert after git changes

(provide 'magit-config)
;;; magit-config.el ends here

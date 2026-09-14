;;; -*- lexical-binding: t -*-

(use-package magit
  :ensure t
  :defer 1               ; deferred 1s
  :custom
  (magit-define-global-key-bindings 'recommended)  ; C-c g dispatch
  (magit-save-repository-buffers 'dontask)          ; autosave
  :config
  (magit-auto-revert-mode 1))                       ; auto-revert

(provide 'magit-config)
;;; magit-config.el ends here

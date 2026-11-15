;;; -*- lexical-binding: t -*-
(use-package magit
  :ensure t
  :demand t
  :custom
  (magit-define-global-key-bindings 'recommended)  ; C-c g dispatch
  (magit-save-repository-buffers 'dontask)          ; autosave
  :config
  (magit-auto-revert-mode 1))                       ; auto-revert

(use-package diff-hl
  :demand t
  :ensure t
  :hook
  (magit-post-refresh . diff-hl-magit-post-refresh) ;; refresh after magit
  :config
  (global-diff-hl-mode 1)   ;; git indicators
  (diff-hl-dired-mode 1))   ;; dired marks

(provide 'vcs-config)
;;; vcs-config.el ends here

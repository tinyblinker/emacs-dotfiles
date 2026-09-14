;;; -*- lexical-binding: t -*-

(use-package diff-hl
  :ensure t
  :defer 1               ; deferred 1s
  :hook
  (magit-post-refresh . diff-hl-magit-post-refresh) ;; refresh after magit
  :config
  (global-diff-hl-mode 1)   ;; git indicators
  (diff-hl-dired-mode 1))   ;; dired marks

(provide 'diff-hl-config)
;;; diff-hl-config.el ends here

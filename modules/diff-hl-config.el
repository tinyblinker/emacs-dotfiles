;;; -*- lexical-binding: t -*-

(use-package diff-hl
  :ensure t
  :defer 1               ; load 1s after idle, not needed at startup
  :hook
  (magit-post-refresh . diff-hl-magit-post-refresh) ;; Refresh indicators after magit commands
  :config
  (global-diff-hl-mode 1)   ;; Show git change indicators in all tracked buffers
  (diff-hl-dired-mode 1))   ;; Show git status marks in Dired

(provide 'diff-hl-config)
;;; diff-hl-config.el ends here

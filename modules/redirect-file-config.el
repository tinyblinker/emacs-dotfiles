;;; -*- lexical-binding: t -*-

;; Redirect org-roam DB
(setq org-roam-db-location (expand-file-name "var/org-roam.db" user-emacs-directory))

;; Redirect tramp files
(setq tramp-persistency-file-name (expand-file-name "var/tramp" user-emacs-directory))

;; Redirect eww-bookmarks
(with-eval-after-load 'eww
  (setq eww-bookmarks-directory (expand-file-name "var/" user-emacs-directory)))

;; Redirect eshell files
(with-eval-after-load 'eshell
  (setq eshell-directory-name (expand-file-name "var/eshell" user-emacs-directory)))

;; Redirect bookmarks
(with-eval-after-load 'bookmark
  (setq bookmark-default-file (expand-file-name "var/bookmarks.eld" user-emacs-directory)))

;; Redirect transient
(with-eval-after-load 'transient
  (setq transient-levels-file (expand-file-name "var/transient/levels.el" user-emacs-directory))
  (setq transient-values-file (expand-file-name "var/transient/values.el" user-emacs-directory))
  (setq transient-history-file (expand-file-name "var/transient/history.el" user-emacs-directory)))

;; Load custom settings
(setq custom-file (expand-file-name "var/custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load custom-file nil :nomessage))

;; Redirect backups and autosaves
(setq backup-directory-alist
      `((".*" . ,(expand-file-name "var/backup/" user-emacs-directory)))
      auto-save-file-name-transforms
      `((".*" ,(expand-file-name "var/auto-save-list/" user-emacs-directory) t))
      auto-save-list-file-prefix
      (expand-file-name "var/auto-save-list/" user-emacs-directory)
      create-lockfiles nil) ;; no lock files

;; recentf/history in var/
(with-eval-after-load 'recentf
  (setq recentf-save-file (expand-file-name "var/recentf" user-emacs-directory)))
(with-eval-after-load 'savehist
  (setq savehist-file (expand-file-name "var/history" user-emacs-directory)))

;; Themes in var/
(setq custom-theme-directory
      (expand-file-name "var/themes/" user-emacs-directory))

(provide 'redirect-file-config)
;;; redirect-file-config.el ends here

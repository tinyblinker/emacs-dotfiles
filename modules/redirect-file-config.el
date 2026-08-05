;;; -*- lexical-binding: t -*-

(setq custom-file (expand-file-name "var/custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load custom-file nil :nomessage))

(setq backup-directory-alist
      `((".*" . ,(expand-file-name "var/backup/" user-emacs-directory)))
      auto-save-file-name-transforms
      `((".*" ,(expand-file-name "var/auto-saves/" user-emacs-directory) t))
      auto-save-list-file-prefix
      (expand-file-name "var/auto-save-list/" user-emacs-directory)
      create-lockfiles nil)

(setq recentf-save-file (expand-file-name "var/recentf" user-emacs-directory))
(setq savehist-file (expand-file-name "var/history" user-emacs-directory))

(provide 'redirect-file-config)
;;; redirect-file-config.el ends here

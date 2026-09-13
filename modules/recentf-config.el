;;; -*- lexical-binding: t -*-

;; Recentf: track recently opened files
(use-package recentf
  :hook (after-init . recentf-mode)
  :custom
  (recentf-exclude '("var/" "elpa/" ".git/" "^/tmp/" "/ssh:" "/sudo:")))

(provide 'recentf-config)
;;; recentf-config.el ends here

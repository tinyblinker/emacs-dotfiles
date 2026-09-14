;;; -*- lexical-binding: t -*-

;; .editorconfig support
(use-package editorconfig
  :ensure t
  :hook (prog-mode . editorconfig-mode))

(provide 'editorconfig-config)
;;; editorconfig-config.el ends here

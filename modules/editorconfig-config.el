;;; -*- lexical-binding: t -*-

;; EditorConfig: apply .editorconfig project settings in programming modes
(use-package editorconfig
  :ensure t
  :hook (prog-mode . editorconfig-mode))

(provide 'editorconfig-config)
;;; editorconfig-config.el ends here

;;; -*- lexical-binding: t -*-
(use-package treesit-auto
  :ensure t
  :custom
  ;; have prompts before auto-install corresponding treesit
  (treesit-auto-install 'prompt)
  :config
  ;; automatic add to auto mode alist
  (treesit-auto-add-to-auto-mode-alist 'all)
  (global-treesit-auto-mode))

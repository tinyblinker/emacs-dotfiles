;;; -*- lexical-binding: t -*-

(global-display-line-numbers-mode 1)
(menu-bar-mode -1)
(tool-bar-mode -1)
(blink-cursor-mode -1)
(scroll-bar-mode -1)
(customize-set-variable 'scroll-step 1)
(customize-set-variable 'initial-scratch-message nil)
(customize-set-variable 'inhibit-startup-screen t)

(use-package keycast
  :ensure t
  :custom
  (keycast-mode-line-mode-remove-tail-elements nil)
  (keycast-mode-line-mode-remove-insert-after 'mode-line-misc-info)
  :config
  (keycast-mode-line-mode))

;; smooth scrolling
(setq auto-window-vscroll nil)
(customize-set-variable 'fast-but-imprecise-scrolling t)
(customize-set-variable 'scroll-conservatively 101)
(customize-set-variable 'scroll-margin 0)
(customize-set-variable 'scroll-preserve-screen-position t)

(provide 'ui-config)
;;; ui-config.el ends here

;;; -*- lexical-binding: t -*-

(set-face-attribute 'default nil
                    :family "JetBrainsMono Nerd Font Mono"
                    :height 150)

(setq default-frame-alist
      '((width . 100) (height . 40)))

(global-display-line-numbers-mode 1)
(menu-bar-mode -1)
(tool-bar-mode -1)
(blink-cursor-mode -1)
(scroll-bar-mode -1)
(setq scroll-step 1
      initial-scratch-message nil
      inhibit-startup-screen t)

(use-package keycast
  :ensure t
  :custom
  (keycast-mode-line-mode-remove-tail-elements nil)
  (keycast-mode-line-mode-remove-insert-after 'mode-line-misc-info)
  :config
  (keycast-mode-line-mode))

(setq auto-window-vscroll nil
      fast-but-imprecise-scrolling t
      scroll-conservatively 101
      scroll-margin 0
      scroll-preserve-screen-position t)

(provide 'ui-config)
;;; ui-config.el ends here

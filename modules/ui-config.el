;;; -*- lexical-binding: t -*-

;; Set default font family and size
(set-face-attribute 'default nil
                    :family "JetBrainsMono Nerd Font Mono"
                    :height 190)

;; Default frame size: 100 columns wide, 40 rows tall
(setq default-frame-alist
      '((width . 100) (height . 40)))

;; Clean up the UI: line numbers on, all chrome off, no startup screen
(global-display-line-numbers-mode 1)
(menu-bar-mode -1)
(tool-bar-mode -1)
(blink-cursor-mode -1)
(scroll-bar-mode -1)
(setq scroll-step 1
      initial-scratch-message nil
      inhibit-startup-screen t)

;; Show pressed key sequences in the mode-line
(use-package keycast
  :ensure t
  :custom
  (keycast-mode-line-mode-remove-tail-elements nil)
  (keycast-mode-line-mode-remove-insert-after 'mode-line-misc-info)
  :config
  (keycast-mode-line-mode))

;; Smooth, pixel-accurate scrolling configuration
(setq auto-window-vscroll nil
      fast-but-imprecise-scrolling t
      scroll-conservatively 101
      scroll-margin 0
      scroll-preserve-screen-position t)

(provide 'ui-config)
;;; ui-config.el ends here

;;; -*- lexical-binding: t -*-

;; Default font
(set-face-attribute 'default nil
                    :family "JetBrainsMono NF"
                    :weight 'bold
                    :slant 'italic
                    :height 180)

;; Visual wrap
(global-visual-line-mode 1)

;; Absolute line numbers
(global-display-line-numbers-mode 1)
(setq display-line-numbers-type t)

;; No menu/tool/scroll bars
(menu-bar-mode -1)
(tool-bar-mode -1)
(blink-cursor-mode -1)
(scroll-bar-mode -1)

;; One line per scroll
(setq scroll-step 1
      initial-scratch-message nil
      inhibit-startup-screen t)

;; Pixel-precise scrolling
(pixel-scroll-precision-mode 1)

(provide 'ui-config)
;;; ui-config.el ends here

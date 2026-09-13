;;; -*- lexical-binding: t -*-

;; Set default font
(set-face-attribute 'default nil
                    :family "JetBrainsMono NF"
                    :weight 'bold
                    :slant 'italic
                    :height 180)

;; Truncate long lines automatically (visual wrap, no hard newlines)
(global-visual-line-mode 1)

;; Absolute line numbers (not relative)
(global-display-line-numbers-mode 1)
(setq display-line-numbers-type t)

;; Clean up the UI chrome: no menu/tool/scroll bars, no blinking cursor
(menu-bar-mode -1)
(tool-bar-mode -1)
(blink-cursor-mode -1)
(scroll-bar-mode -1)

;; One-line-at-a-time keyboard scrolling (1 = one line per scroll event)
(setq scroll-step 1
      initial-scratch-message nil
      inhibit-startup-screen t)

;; Smooth pixel-precise scrolling (Emacs 29+)
(pixel-scroll-precision-mode 1)

(provide 'ui-config)
;;; ui-config.el ends here

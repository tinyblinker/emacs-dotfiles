;;; -*- lexical-binding: t -*-

;; Set default font
(set-face-attribute 'default nil
                    :family "JetBrainsMono NF"
                    :weight 'bold
                    :slant 'italic
                    :height 180)

;; truncate line automatically without insert [enter]
(global-visual-line-mode 1)

;; Clean up the UI: line numbers on, all chrome off, no startup screen
(global-display-line-numbers-mode 1)
(setq display-line-numbers-type 'relative)
(menu-bar-mode -1)
(tool-bar-mode -1)
(blink-cursor-mode -1)
(scroll-bar-mode -1)
;; One-line-at-a-time keyboard scrolling (1 = one line per scroll event)
(setq scroll-step 1
      initial-scratch-message nil
      inhibit-startup-screen t)

;; Highlight matching parentheses
(show-paren-mode 1)

;; Smooth pixel-precise scrolling (Emacs 29+)
(pixel-scroll-precision-mode 1)

;; Show pressed key sequences in the mode-line
(use-package keycast
  :ensure t
  :defer 1               ; load 1s after idle, mode-line display can wait
  :custom
  ;; Show all key sequence elements (do not strip duplicates from the tail)
  (keycast-mode-line-mode-remove-tail-elements nil)
  ;; Place keycast near the right side of the mode-line
  (keycast-mode-line-mode-remove-insert-after 'mode-line-misc-info)
  :config
  (keycast-mode-line-mode))

(provide 'ui-config)
;;; ui-config.el ends here

;;; -*- lexical-binding: t -*-

;; Default font
(set-face-attribute 'default nil
                    :family "JetBrainsMono NF"
                    :weight 'normal
                    :slant 'italic
                    :height 180)

;; truncate line wrappers
(global-visual-line-mode -1)
(setq truncate-lines t)
(setq word-wrap nil)

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

(use-package diff-hl
  :ensure t
  :hook
  (magit-post-refresh . diff-hl-magit-post-refresh) ;; refresh after magit
  :config
  (global-diff-hl-mode 1)   ;; git indicators
  (diff-hl-dired-mode 1))   ;; dired marks

(provide 'ui-config)
;;; ui-config.el ends here

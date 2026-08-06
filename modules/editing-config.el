;;; -*- lexical-binding: t -*-

;; Auto-revert buffers when their files change on disk
(setq global-auto-revert-non-file-buffers t)
(global-auto-revert-mode 1)

;; Scroll eshell to the bottom when typing input
(setq eshell-scroll-to-bottom-on-input 'this)

;; When switching buffers in a dedicated window, reuse or pop up another window
(setq switch-to-buffer-in-dedicated-window 'pop
      switch-to-buffer-obey-display-actions t)

;; Automatically use fundamental-mode for files with very long lines
(use-package so-long
  :config (global-so-long-mode 1))

;; Allow repeating commands by pressing only their last key (e.g. C-x o o o)
(use-package repeat
  :config (repeat-mode 1))

;; Prefer spaces over tabs, speed up bidi by disabling it
(setq-default indent-tabs-mode nil
              bidi-paragraph-direction 'left-to-right
              bidi-inhibit-bpa t)
;; Misc defaults: deduplicate kill ring, save bookmarks immediately, prefer newer files
(setq kill-do-not-save-duplicates t
      bookmark-save-flag 1
      Man-notify-method 'aggressive
      ediff-window-setup-function 'ediff-setup-windows-plain
      load-prefer-newer t)

;; Make scripts executable on save if they start with a shebang
(add-hook 'after-save-hook
          #'executable-make-buffer-file-executable-if-script-p)

;; Auto-insert matching parentheses, quotes, brackets globally
(electric-pair-mode 1)

(provide 'editing-config)
;;; editing-config.el ends here

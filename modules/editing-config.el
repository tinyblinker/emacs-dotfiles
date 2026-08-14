;;; -*- lexical-binding: t -*-

;; Auto-revert buffers when their files change on disk
(setq global-auto-revert-non-file-buffers t)
(global-auto-revert-mode 1)

;; Scroll eshell to the bottom when typing input ('this = only when this window is selected)
(setq eshell-scroll-to-bottom-on-input 'this)

;; When switching buffers in a dedicated window, reuse or pop up another window
(setq switch-to-buffer-in-dedicated-window 'pop ;; Pop up a new window instead of signaling an error
      switch-to-buffer-obey-display-actions t)  ;; Respect display-buffer-alist rules

;; Automatically use fundamental-mode for files with very long lines
(use-package so-long
  :config (global-so-long-mode 1))

;; Allow repeating commands by pressing only their last key (e.g. C-x o o o)
(use-package repeat
  :config (repeat-mode 1))

;; Prefer spaces over tabs; disable bidirectional text for performance in terminals
(setq-default indent-tabs-mode nil
              bidi-paragraph-direction 'left-to-right ;; Force LTR rendering, skips bidi analysis
              bidi-inhibit-bpa t)                     ;; Inhibit bidirectional paragraph adjustment
;; Misc defaults: deduplicate kill ring, save bookmarks immediately, prefer newer files
(setq kill-do-not-save-duplicates t     ;; Skip duplicate kill-ring entries
      bookmark-save-flag 1              ;; Auto-save bookmarks after each change
      Man-notify-method 'aggressive     ;; Reuse window for man pages instead of popping new one
      ediff-window-setup-function 'ediff-setup-windows-plain ;; Single-frame ediff layout
      load-prefer-newer t)              ;; Load newer .elc if both .el and .elc exist

;; Make scripts executable on save if they start with a shebang
(add-hook 'after-save-hook
          #'executable-make-buffer-file-executable-if-script-p)

;; Auto-insert matching parentheses, quotes, brackets globally
(electric-pair-mode 1)

;; delete selected things when paste things
(delete-selection-mode 1)

(provide 'editing-config)
;;; editing-config.el ends here

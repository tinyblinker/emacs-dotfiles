;;; -*- lexical-binding: t -*-
(use-package savehist
  :custom
  (savehist-additional-variables '(kill-ring register-alist search-ring regexp-search-ring))
  :config (savehist-mode 1))

(use-package so-long
  :config (global-so-long-mode 1))

(use-package repeat
  :config (repeat-mode 1))

(use-package recentf
  :hook (after-init . recentf-mode)
  :custom
  (recentf-exclude '("var/" "elpa/" ".git/" "^/tmp/" "/ssh:" "/sudo:")))

;; Highlight + auto-insert parens
(show-paren-mode 1)       ;; highlight matching paren
(electric-pair-mode 1)    ;; auto-insert pairs

;; .editorconfig support
(use-package editorconfig
  :ensure t
  :hook (prog-mode . editorconfig-mode))

;; Disable overwrite-mode
(add-hook 'after-change-major-mode-hook
          (lambda () (when (overwrite-mode) (overwrite-mode -1))))
(keymap-global-unset "<insert>")
(keymap-global-unset "<insertchar>")

;; mode-line: do not show buffer-identification(buffer's name)
(setq-default mode-line-buffer-identification nil)

;; Scroll eshell on input
(setq eshell-scroll-to-bottom-on-input 'this)

;; Pop new window for dedicated
(setq switch-to-buffer-in-dedicated-window 'pop
      switch-to-buffer-obey-display-actions t)

;; Spaces, no bidi
(setq-default indent-tabs-mode nil
              bidi-paragraph-direction 'left-to-right
              bidi-inhibit-bpa t)

;; Misc defaults
(setq kill-do-not-save-duplicates t
      bookmark-save-flag 1
      Man-notify-method 'aggressive
      ediff-window-setup-function 'ediff-setup-windows-plain
      load-prefer-newer t)

;; Chmod scripts on save
(add-hook 'after-save-hook
          #'executable-make-buffer-file-executable-if-script-p)

;; Replace selection on paste
(delete-selection-mode 1)

;; Reload buffers on disk change
(setq global-auto-revert-non-file-buffers t)
(global-auto-revert-mode 1)

(provide 'editor-config)
;;; editor-config.el ends here

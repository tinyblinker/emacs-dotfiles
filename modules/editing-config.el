;;; -*- lexical-binding: t -*-

;; Global editing defaults

;; Disable overwrite-mode when entering a new major mode, and unbind the keys
(add-hook 'after-change-major-mode-hook
          (lambda () (when (overwrite-mode) (overwrite-mode -1))))
(keymap-global-unset "<insert>")
(keymap-global-unset "<insertchar>")

;; Scroll eshell to the bottom when typing input ('this = only when selected)
(setq eshell-scroll-to-bottom-on-input 'this)

;; When switching buffers in a dedicated window, pop up a new window instead
(setq switch-to-buffer-in-dedicated-window 'pop
      switch-to-buffer-obey-display-actions t)

;; Prefer spaces over tabs; disable bidi for terminal performance
(setq-default indent-tabs-mode nil
              bidi-paragraph-direction 'left-to-right
              bidi-inhibit-bpa t)

;; Misc defaults: deduplicate kill ring, save bookmarks, prefer newer files
(setq kill-do-not-save-duplicates t
      bookmark-save-flag 1
      Man-notify-method 'aggressive
      ediff-window-setup-function 'ediff-setup-windows-plain
      load-prefer-newer t)

;; Make scripts executable on save if they start with a shebang
(add-hook 'after-save-hook
          #'executable-make-buffer-file-executable-if-script-p)

;; Replace selected text when pasting
(delete-selection-mode 1)

(provide 'editing-config)
;;; editing-config.el ends here

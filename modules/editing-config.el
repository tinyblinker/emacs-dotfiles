;;; -*- lexical-binding: t -*-

;; Global editing defaults

;; Disable overwrite-mode
(add-hook 'after-change-major-mode-hook
          (lambda () (when (overwrite-mode) (overwrite-mode -1))))
(keymap-global-unset "<insert>")
(keymap-global-unset "<insertchar>")

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

(provide 'editing-config)
;;; editing-config.el ends here

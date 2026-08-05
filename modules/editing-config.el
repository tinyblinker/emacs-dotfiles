;;; -*- lexical-binding: t -*-

;; auto-revert
(customize-set-variable 'global-auto-revert-non-file-buffers t)
(global-auto-revert-mode 1)

;; eshell
(customize-set-variable 'eshell-scroll-to-bottom-on-input 'this)

;; switch-to-buffer
(customize-set-variable 'switch-to-buffer-in-dedicated-window 'pop)
(customize-set-variable 'switch-to-buffer-obey-display-actions t)

;; completion
(customize-set-variable 'tab-always-indent 'complete)
(customize-set-variable 'completion-cycle-threshold 3)
(customize-set-variable 'completions-detailed t)
(customize-set-variable 'xref-show-definitions-function
                        #'xref-show-definitions-completing-read)

(use-package so-long
  :config (global-so-long-mode 1))

(use-package repeat
  :config (repeat-mode 1))

(use-package completion-preview
  :config
  (global-completion-preview-mode -1)
  :bind (:map completion-preview-active-mode-map
              ("M-n" . completion-preview-next-candidate)
              ("M-p" . completion-preview-prev-candidate)))

;; editor settings
(setq-default indent-tabs-mode nil)
(setq-default bidi-paragraph-direction 'left-to-right)
(setq-default bidi-inhibit-bpa t)
(customize-set-variable 'kill-do-not-save-duplicates t)
(customize-set-variable 'bookmark-save-flag 1)
(customize-set-variable 'Man-notify-method 'aggressive)
(customize-set-variable 'ediff-window-setup-function
                        'ediff-setup-windows-plain)
(customize-set-variable 'load-prefer-newer t)

(add-hook 'after-save-hook
          #'executable-make-buffer-file-executable-if-script-p)

(provide 'editing-config)
;;; editing-config.el ends here

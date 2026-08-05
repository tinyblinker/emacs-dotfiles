;;; -*- lexical-binding: t -*-

(setq global-auto-revert-non-file-buffers t)
(global-auto-revert-mode 1)

(setq eshell-scroll-to-bottom-on-input 'this)

(setq switch-to-buffer-in-dedicated-window 'pop
      switch-to-buffer-obey-display-actions t)

(setq tab-always-indent 'complete
      completion-cycle-threshold 3
      completions-detailed t
      xref-show-definitions-function #'xref-show-definitions-completing-read)

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

(setq-default indent-tabs-mode nil
              bidi-paragraph-direction 'left-to-right
              bidi-inhibit-bpa t)
(setq kill-do-not-save-duplicates t
      bookmark-save-flag 1
      Man-notify-method 'aggressive
      ediff-window-setup-function 'ediff-setup-windows-plain
      load-prefer-newer t)

(add-hook 'after-save-hook
          #'executable-make-buffer-file-executable-if-script-p)

(provide 'editing-config)
;;; editing-config.el ends here

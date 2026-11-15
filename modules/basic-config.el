;;; -*- lexical-binding: t -*-

;; Default font
(set-face-attribute 'default nil
                    :family "JetBrainsMono NF"
                    :weight 'normal
                    :slant 'italic
                    :height 180)

(show-paren-mode 1)       
(electric-pair-mode 1)    
(global-so-long-mode 1)
(repeat-mode 1)
(delete-selection-mode 1) 
(global-auto-revert-mode 1)
(savehist-mode 1)
(global-visual-line-mode -1)
(menu-bar-mode -1)
(tool-bar-mode -1)
(blink-cursor-mode -1)
(scroll-bar-mode -1)
(global-display-line-numbers-mode 1)
(pixel-scroll-precision-mode 1)

(setq-default indent-tabs-mode nil
              bidi-paragraph-direction 'left-to-right
              bidi-inhibit-bpa t
              mode-line-buffer-identification nil)

(setq kill-do-not-save-duplicates t
      bookmark-save-flag 1
      Man-notify-method 'aggressive
      ediff-window-setup-function 'ediff-setup-windows-plain
      load-prefer-newer t
      switch-to-buffer-in-dedicated-window 'pop
      switch-to-buffer-obey-display-actions t
      global-auto-revert-non-file-buffers t
      savehist-additional-variables '(kill-ring register-alist)
      recentf-exclude '("var/" "elpa/" "/\\.git/" "^/tmp/" "/ssh:" "/sudo:")
      truncate-lines t
      word-wrap nil
      display-line-numbers-type t
      scroll-step 1
      initial-scratch-message nil
      inhibit-startup-screen t)

(add-hook 'after-change-major-mode-hook
          (lambda () (when (overwrite-mode) (overwrite-mode -1))))
(add-hook 'after-save-hook
          #'executable-make-buffer-file-executable-if-script-p)
(add-hook 'prog-mode
          #'editorconfig-mode)
(add-hook 'after-init-hook
          #'recentf-mode)

(keymap-global-unset "<insert>" "<insertchar>")

(use-package embrace
  :ensure t
  :bind (("C-c e a" . embrace-add)     ;; add
         ("C-c e c" . embrace-change)  ;; change
         ("C-c e d" . embrace-delete))) ;; delete

(use-package keycast
  :ensure t
  :demand t
  :config
  (keycast-mode-line-mode 1))

(provide 'basic-config)
;;; basic-config.el ends here

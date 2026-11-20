;;; -*- lexical-binding: t -*-

;; Default font
(set-face-attribute 'default nil
                    :family "JetBrainsMono NF"
                    :weight 'normal
                    :slant 'italic
                    :height 160)
(dolist (charset '(han cjk-misc kana bopomofo))
  (set-fontset-font t charset
                    (font-spec :family "Sarasa Mono SC")))

(electric-pair-mode 1)    
(global-so-long-mode 1)
(repeat-mode 1)
(delete-selection-mode 1) 
(global-auto-revert-mode 1)
(savehist-mode 1)
(global-visual-line-mode 1)
(menu-bar-mode -1)
(tool-bar-mode -1)
(blink-cursor-mode -1)
(scroll-bar-mode -1)
(add-hook 'prog-mode-hook #'display-line-numbers-mode)
(pixel-scroll-precision-mode 1)
(editorconfig-mode 1)

(setq-default indent-tabs-mode nil
              tab-width 4
              bidi-paragraph-direction 'left-to-right
              bidi-inhibit-bpa t)

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
      scroll-step 1
      initial-scratch-message nil
      inhibit-startup-screen t
      ibuffer-movement-cycle nil
      ibuffer-old-time 24)

(setopt visual-line-fringe-indicators '(nil right-curly-arrow)
        mode-line-collapse-minor-modes '(not))

(add-hook 'after-save-hook
          #'executable-make-buffer-file-executable-if-script-p)
(add-hook 'after-init-hook
          #'recentf-mode)

(define-key global-map [remap lisp-buffer] #'ibuffer-list-buffers)
(keymap-global-unset "<insert>" "<insertchar>")

(use-package which-key
  :ensure t
  :demand t
  :custom
  (which-key-idle-delay 0.5)
  (which-key-min-display-lines 3)
  (which-key-max-description-length 27)
  ;; Show on C-h
  (which-key-show-early-on-C-h t)
  ;; Popup at bottom
  (which-key-side-window-location 'bottom)
  ;; Key/desc separator
  (which-key-separator " -> ")
  :config
  (which-key-mode 1))

(use-package keycast
  :ensure t
  :demand t
  :config
  (keycast-header-line-mode 1))

(provide 'basic-config)
;;; basic-config.el ends here

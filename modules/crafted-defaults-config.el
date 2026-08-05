;;; -*- lexical-binding: t; -*-

;; define groups for crafted default settings
(defgroup crafted-defaults '()
  "Customizations for Crafted Emacs - Defaults."
  :tag "Crafted Defaults"
  :group 'crafted)

;; define a customized variable
(defcustom crafted-windows-prefix-key "C-c w"
  "Configure the prefix key for window movement bindings.

Movement commands provided by `windmove' package, `winner-mode'
also enables undo functionality if the window layout changes."
  :group 'crafted-defaults
  :type 'string)

;; variables about "auto-revert"
(customize-set-variable 'global-auto-revert-non-file-buffers t)
(global-auto-revert-mode 1)


;; variables about the eshell
(customize-set-variable 'eshell-scroll-to-bottom-on-input 'this)

;; variables about the "switch-to-buffer"
(customize-set-variable 'switch-to-buffer-in-dedicated-window 'pop)
(customize-set-variable 'switch-to-buffer-obey-display-actions t)

;; variables about "completions"
(customize-set-variable 'tab-always-indent 'complete)
(customize-set-variable 'completion-cycle-threshold 3)
(customize-set-variable 'completion-category-overrides
                        '((file (styles . (partial-completion)))))
(customize-set-variable 'completions-detailed t)
(customize-set-variable 'xref-show-definitions-function
                        #'xref-show-definitions-completing-read)

(use-package so-long
  :config (global-so-long-mode 1))

(use-package repeat
  :config (repeat-mode 1))

(use-package completion-preview
  :config
  (global-completion-preview-mode 1)
  :bind (:map completion-preview-active-mode-map
              ("M-n" . completion-preview-next-candidate)
              ("M-p" . completion-preview-prev-candidate)))

;; miscs variables about "editor settings"
(setq-default indent-tabs-mode nil)
(setq-default bidi-paragraph-direction 'left-to-right)
(setq-default bidi-inhibit-bpa t)
(customize-set-variable 'kill-do-not-save-duplicates t)
(customize-set-variable 'bookmark-save-flag 1)
(customize-set-variable 'Man-notify-method 'aggressive)
(customize-set-variable 'ediff-window-setup-function
                        'ediff-setup-windows-plain)
(customize-set-variable 'load-prefer-newer t)


(use-package ibuffer
  :bind ("<remap><list-buffer>" . ibuffer-list-buffers)
  :custom
  (ibuffer-movement-cycle nil)
  (ibuffer-old-time 24))



(add-to-list 'display-buffer-alist
             '("\\*Help\\*"
               (display-buffer-reuse-window display-buffer-pop-up-window)))
(add-to-list 'display-buffer-alist
             '("\\*Completions\\*"
               (display-buffer-reuse-window display-buffer-pop-up-window)
               (inhibit-same-window . t)
               (window-height . 10)))
(use-package recentf
  :hook (after-init . recentf-mode))

(use-package savehist
  :config (savehist-mode 1))

(add-hook 'after-save-hook
          #'executable-make-buffer-file-executable-if-script-p)

(use-package dired
  :custom
  (dried-dwim-target t)
  (dried-auto-revert-buffer t))

;; variables about "dictionary" 
(use-package dictionary
  :bind ("M-#" . dictionary-lookup-definition)
  :config
  (add-to-list 'display-buffer-alist
               '("^\\*Dictionary\\*"
                 (display-buffer-in-side-window)
                 (side . left)
                 (window-width . 70))))

;; settings for plain text's spellcheck and in codes' spellcheck of comments
(use-package ispell
  :config
  (when (executable-find ispell-program-name)
    (add-hook 'text-mode-hook #'flyspell-mode)
    (add-hook 'prog-mode-hook #'flyspell-prog-mode)))

;; config the "hydra" and "dumb-jump"
(use-package dumb-jump
  :ensure t
  :hook
  (xref-backend-functions . dumb-jump-xref-activate))

(use-package hydra
  :ensure t
  :after dumb-jump
  :config
  (defhydra dumb-jump-hydra (:color blue :columns 3)
            "Dumb Jump"
            ("j" dumb-jump-go "Go")
            ("o" dumb-jump-go-other-window "Other window")
            ("e" dumb-jump-go-prefer-external "Go external")
            ("x" dumb-jump-go-prefer-external-other-window "Go external other window")
            ("i" dumb-jump-go-prompt "Prompt")
            ("l" dumb-jump-quick-look "Quick look")
            ("b" dumb-jump-back "Back"))
  :bind (:map dumb-jump-mode-map
              ("C-M-y" . dumb-jump-hydra/body)))

;; settings about the windows managements
(use-package winner
  :config
  (winner-mode 1)
  (define-prefix-command 'crafted-windows-key-map)
  :bind (("C-c w" . crafted-windows-key-map)
         :map crafted-windows-key-map
         ("u" . winner-undo)
         ("r" . winner-redo)
         ("n" . windmove-down)
         ("p" . windmove-up)
         ("b" . windmove-left)
         ("f" . windmove-right)))

;; scroll the screen smoothly
(setq auto-window-vscroll nil)
(customize-set-variable 'fast-but-imprecise-scrolling t)
(customize-set-variable 'scroll-conservatively 101)
(customize-set-variable 'scroll-margin 0)
(customize-set-variable 'scroll-preserve-screen-position t)

;; provide necessary features
(provide 'crafted-defaults-config)
;;; crafted-defaults-config.el ends here

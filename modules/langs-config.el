;;; -*- lexical-binding: t -*-
(use-package elisp-demos
  :ensure t
  :config
  (advice-add 'describe-function-1 :after #'elisp-demos-advice-describe-function-1))

(use-package treesit-fold
  :vc (:url "https://github.com/emacs-tree-sitter/treesit-fold")
  :commands (treesit-fold-mode
             global-treesit-fold-mode
             treesit-fold-toggle
             treesit-fold-open-all
             treesit-fold-close-all)
  :hook (prog-mode . treesit-fold-mode)
  :custom
  (treesit-fold-line-count-show t)
  :config
  (set-face-attribute 'treesit-fold-replacement-face nil
                      :inherit 'shadow
                      :weight 'bold))

;; fold keys
(global-set-key (kbd "C-c C-c C-g") #'treesit-fold-toggle)
(global-set-key (kbd "C-c C-c C-c") #'treesit-fold-close-all)
(global-set-key (kbd "C-c C-c C-o") #'treesit-fold-open-all)

(use-package treesit-auto
  :ensure t
  :custom
  ;; have prompts before auto-install corresponding treesit
  (treesit-auto-install 'prompt)
  :config
  ;; automatic add to auto mode alist
  (treesit-auto-add-to-auto-mode-alist 'all)
  (global-treesit-auto-mode))

(use-package eglot
  :custom
  (eglot-autoshutdown t) ;; autoshutdown
  :hook
  ;; inlay hints after connect
  ((eglot-managed-mode . eglot-inlay-hints-mode))
  :bind (:map eglot-mode-map
              ("C-c l a" . eglot-code-actions)
              ("C-c l r" . eglot-rename)
              ("C-c l f" . eglot-format-buffer)
              ("C-c l ." . xref-find-definitions)
              ("C-c l ," . xref-find-references)))

(use-package flymake
  :bind (("C-c ! n" . flymake-goto-next-error)
         ("C-c ! p" . flymake-goto-prev-error))
  :config
  (setq-default flymake-indicator-type 'margins
                flymake-margin-indicator-position 'left-margin
                flymake-margin-indicators-string
                '((error "✖" compilation-error)
                  (warning "▲" compilation-warning)
                  (note "●" compilation-info))))

(use-package flymake-popon
  :ensure t
  :hook (flymake-mode . flymake-popon-mode))

(provide 'langs-config)
;;; langs-config.el ends here

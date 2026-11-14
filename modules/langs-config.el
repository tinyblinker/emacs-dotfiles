;;; -*- lexical-binding: t -*-
(use-package magit
  :ensure t
  :demand t
  :custom
  (magit-define-global-key-bindings 'recommended)  ; C-c g dispatch
  (magit-save-repository-buffers 'dontask)          ; autosave
  :config
  (magit-auto-revert-mode 1))                       ; auto-revert

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
  :custom
  (treesit-fold-line-count-show t)
  :config
  (global-treesit-fold-mode 1)
  (set-face-attribute 'treesit-fold-replacement-face nil
                      :inherit 'shadow
                      :weight 'bold))

;; global-keys
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
         ("C-c ! p" . flymake-goto-prev-error)))

(use-package flymake-popon
  :ensure t
  :hook (flymake-mode . flymake-popon-mode))

(provide 'langs-config)
;;; langs-config.el ends here

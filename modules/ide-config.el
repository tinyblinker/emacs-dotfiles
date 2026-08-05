;;; -*- lexical-binding: t; -*-

;; when in "graphic" or "daemon" mode: need some variables
(use-package exec-path-from-shell
  :ensure t
  :if (and (or (display-graphic-p) (daemonp))
           (not (member system-type '(ms-dos windows-nt cygwin haiku android))))
  :config
  (dolist (var '("SSH_AUTH_SOCK" "SSH_AGENT_PID" "GPG_AGENT_INFO" "LANG"
                 "LC_CTYPE" "GOPATH" "PYTHONPATH" "JAVA_HOME"))
    (add-to-list 'exec-path-from-shell-variables var))
  (exec-path-from-shell-initialize))

;; config the "eglot"
(use-package eglot
  :custom (eglot-autoshutdown t)
  :hook (rust-ts-mode . eglot-ensure))

;; Config the treesit-auto
(use-package treesit-auto
  :if (member "TREE_SITTER" (split-string system-configuration-features))
  :ensure t
  :custom
  (treesit-auto-langs '(
                        rust
                        bash))
  :init
  (setq treesit-extra-load-path
        (list (expand-file-name "tree-sitter" user-emacs-directory)))
  :config
  (global-treesit-auto-mode)
  (treesit-auto-install-all)
  (treesit-auto-add-to-auto-mode-alist))

(use-package editorconfig
  :ensure t
  :hook (prog-mode . editorconfig-mode))

(use-package rust-mode
  :ensure t
  :after rust-ts-mode
  :bind (:map rust-ts-mode-map
              ("C-c C-c C-u" . #'rust-compile)
              ("C-c C-c C-k" . #'rust-check)
              ("C-c C-c C-t" . #'rust-test)
              ("C-c C-c C-l" . #'rust-run-clippy)
              ("C-c C-f" . #'rust-format-buffer)))

(provide 'ide-config)
;;; ide-config.el ends here

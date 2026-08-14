;;; -*- lexical-binding: t; -*-

;; Import shell environment variables when running in GUI or daemon mode
;; (Terminal Emacs inherits the shell env; GUI/daemon must pull it in explicitly)
(use-package exec-path-from-shell
  :ensure t
  :if (and (or (display-graphic-p) (daemonp))
           (not (member system-type '(ms-dos windows-nt cygwin haiku android))))
  :config
  (dolist (var '("SSH_AUTH_SOCK" "SSH_AGENT_PID" "GPG_AGENT_INFO" "LANG"
                 "LC_CTYPE" "GOPATH" "PYTHONPATH" "JAVA_HOME"))
    (add-to-list 'exec-path-from-shell-variables var))
  (exec-path-from-shell-initialize))

;; Eglot: auto-start LSP server (rust-analyzer) in Rust tree-sitter mode
(use-package eglot
  :custom (eglot-autoshutdown t) ;; Shut down LSP server when last managed buffer is closed
  :hook
  (rust-ts-mode . eglot-ensure)
  (rust-mode . eglot-ensure)
  :bind (:map eglot-mode-map
              ("C-c l a" . eglot-code-actions)
              ("C-c l r" . eglot-rename)
              ("C-c l f" . eglot-format-buffer)
              ("C-c l ." . xref-find-definitions)
              ("C-c l ," . xref-find-references)))

;; Show type annotations inline via LSP inlay hints on Rust buffers (Emacs 30+)
(add-hook 'rust-ts-mode-hook #'eglot-inlay-hints-mode)

;; Apply .editorconfig project settings automatically in programming modes
(use-package editorconfig
  :ensure t
  :hook (prog-mode . editorconfig-mode))

;; Show the current project name in the mode line; click to open the project menu
(setq project-mode-line t)

(provide 'ide-config)
;;; ide-config.el ends here

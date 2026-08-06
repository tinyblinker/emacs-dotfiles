;;; -*- lexical-binding: t; -*-

;; Import shell environment variables (SSH, PATH, etc.) when running in GUI or daemon mode
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
  :custom (eglot-autoshutdown t)
  :hook (rust-ts-mode . eglot-ensure))

;; Apply .editorconfig project settings automatically in programming modes
(use-package editorconfig
  :ensure t
  :hook (prog-mode . editorconfig-mode))

(provide 'ide-config)
;;; ide-config.el ends here

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
  :hook (rust-ts-mode . eglot-ensure)
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

;; envrc.el: enable direnv support in emacs
(use-package envrc
  :ensure t
  :config
  (envrc-global-mode))

;; Treemacs: tree-style file explorer sidebar for project navigation
(use-package treemacs
  :ensure t
  :defer t                                       ;; Load lazily on first invocation
  :init
  (global-set-key (kbd "C-c t") #'treemacs-select-window) ;; Toggle sidebar
  :config
  (progn
    (setq treemacs-width 35)                     ;; Sidebar width in characters
    (setq treemacs-position 'left)               ;; Dock on the left side
    (setq treemacs-show-cursor nil)              ;; Hide cursor in the tree
    (setq treemacs-no-delete-other-windows t)    ;; Protect sidebar from delete-other-windows
    (setq treemacs-silent-refresh nil)           ;; Log a message on manual refresh
    (setq treemacs-show-hidden-files t)          ;; Show dotfiles
    (setq treemacs-space-between-root-nodes t)   ;; Add a blank line between project roots
    (setq treemacs-collapse-dirs (if (executable-find "python3") 3 0)) ;; Collapse single-child dirs
    (treemacs-follow-mode t)                     ;; Auto-focus the current file in the tree
    (treemacs-filewatch-mode t)                  ;; Auto-refresh when files change on disk
    (treemacs-fringe-indicator-mode 'always)     ;; Show a fringe bar on the current line
    (pcase (cons (not (null (executable-find "git")))
                 (not (null (executable-find "python3"))))
      (`(t . t)
       (treemacs-git-mode 'deferred))            ;; Full git coloring with async python
      (`(t . _)
       (treemacs-git-mode 'simple)))))           ;; Basic git coloring without python

;; Treemacs-magit: keep treemacs git faces in sync after magit stage/unstage/commit
(use-package treemacs-magit
  :ensure t
  :after (treemacs magit))                       ;; Hooks into magit events automatically

(provide 'ide-config)
;;; ide-config.el ends here

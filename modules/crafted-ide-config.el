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
  :init
  (defvar crafted-ide-eglot-excluded-modes '(clojure-mode lisp-mode scheme-mode)
    "Major modes to exclude from automatic eglot activation.")

  (defun crafted-ide--lsp-bin-exists-p (mode-spec)
    "Return non-nil if the LSP binary for MODE-SPEC is found.
MODE-SPEC is a cons cell (mode . server-command) from `eglot-server-programs'."
    (let ((server (cdr mode-spec)))
      (if (functionp server)
          (condition-case nil
              (car (funcall server))
            (error nil))
        (executable-find (car server)))))

  (defun crafted-ide-eglot-auto-ensure-all ()
    "Add `eglot-ensure' to major mode hooks where the LSP binary is available.
Skips modes listed in `crafted-ide-eglot-excluded-modes'."
    (dolist (mode-spec eglot-server-programs)
      (let ((mode (car mode-spec)))
        (when (and (symbolp mode)
                   (fboundp mode)
                   (not (memq mode crafted-ide-eglot-excluded-modes))
                   (crafted-ide--lsp-bin-exists-p mode-spec))
          (add-hook (intern (format "%s-hook" mode)) #'eglot-ensure))))))

;; Config the treesit-auto
(use-package treesit-auto
:if (member "TREE_SITTER" (split-string system-configuration-features))
  :ensure t
  :config
  :custom
  (tree-sitter-auto-langs '(python rust bash asm))
  :config
  (global-treesit-auto-mode)
  (treesit-auto-install-all)
  (treesit-auto-add-to-auto))

;; config the combobulate
(use-package combobulate
  :if (member "TREE_SITTER" (split-string system-configuration-features))
  :ensure t
  :hook (prog-mode . combobulate-mode))

;; require the "editorconfig" and the "ibuffer-project" for setups
(use-package editorconfig
  :ensure t
  :hook (prog-mode . editorconfig-mode))

(use-package ibuffer-project
  :ensure t
  :init
  (defun crafted-ide-enhance-ibuffer-with-ibuffer-project ()
    "Set up integration for `ibuffer' with `ibuffer-project'."
    (setq ibuffer-filter-groups (ibuffer-project-generate-filter-groups))
    (unless (eq ibuffer-sorting-mode 'project-file-relative)
      (ibuffer-do-sort-by-project-file-relative)))
  :hook
  (ibuffer . crafted-ide-enhance-ibuffer-with-ibuffer-project))

;; use the aggressive-indent
(use-package aggressive-ident
  :ensure t
  :hook (prog-mode . aggressive-indent-mode))

;; provide the necessary feature
(provide 'crafted-ide-config)
;;; crafted-ide-config.el ends here

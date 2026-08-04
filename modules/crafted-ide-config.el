;;; -*- lexical-binding: t; -*-

;; customized vaiables
(customize-set-variable 'eglot-autoshutdown t)

;; when in "graphic" or "daemon" mode: need some variables
(when (or (display-graphic-p)
          (daemonp))
  (when (require 'exec-path-from-shell nil :noerror)
    (dolist (var '("SSH_AUTH_SOCK" "SSH_AGENT_PID" "GPG_AGENT_INFO" "LANG"
                    "LC_CTYPE" "GOPATH" "PYTHONPATH" "JAVA_HOME"))
      (add-to-list 'exec-path-from-shell-variables var))
    (exec-path-from-shell-initialize)))

;; helper functions to "add eglot hooks"
(defun crafted-ide--add-eglot-hooks (mode-list)
  "Add `eglot-ensure' to modes in MODE-LIST.

The mode must be loaded, i.e. found with `fboundp'.  A mode which
is not loaded will not have a hook added, in which case add it
manually with something like this:

`(add-hook 'some-mode-hook #'eglot-ensure)'"
  (dolist (mode-def mode-list)
    (let ((mode (if (listp mode-def) (car mode-def) mode-def)))
      (cond
       ((listp mode) (crafted-ide--add-eglot-hooks mode))
       (t
        (when (and (fboundp mode)
                   (not (eq 'clojure-mode mode))
                   (not (eq 'lisp-mode mode))
                   (not (eq 'scheme-mode mode)))
          (let ((hook-name (format "%s-hook" (symbol-name mode))))
            (message "adding eglot to %s" hook-name)
            (add-hook (intern hook-name) #'eglot-ensure))))))))

;; helper function to "check if the corresponding 'lsp servers' is installed"
(defun crafted-ide--lsp-bin-exists-p (mode-def)
  "Return non-nil if LSP binary of MODE-DEF is found via `executable-find'."
  (let ((lsp-program (cdr mode-def)))
    (if (functionp lsp-program)
        (condition-case nil
            (car (funcall lsp-program))
          (error nil))
      (executable-find (car lsp-program)))))

;; add eglot (the built-in lsp client support) to crresponding major-modes
(defun crafted-ide-eglot-auto-ensure-all ()
  "Add `eglot-ensure' to major modes that offer LSP support.

Major modes are only selected if the major mode's associated LSP
binary is detected on the system."
  (when (require 'eglot nil :noerror)
    (crafted-ide--add-eglot-hooks (seq-filter
                                   #'crafted-ide--lsp-bin-exists-p
                                   eglot-server-programs))))

;; helper function: tree-sitter configs for emacs 29 or later
(defun crafted-ide--configure-tree-sitter (opt-in-only)
  "Configure tree-sitter for Emacs 29 or later.

OPT-IN-ONLY is a list of symbols of language grammars to
auto-install instead of all grammars."
  (when (member "TREE_SITTER" (split-string system-configuration-features))
    (when (require 'treesit-auto nil :noerror)
      (when opt-in-only
        (if (listp opt-in-only)
            (customize-set-variable 'treesit-auto-langs opt-in-only)
          (customize-set-variable 'treesit-auto-langs (list opt-in-only))))
      (global-treesit-auto-mode)
      (treesit-auto-install-all)
      (treesit-auto-add-to-auto-mode-alist))
    (when (locate-library "combobulate")
      (add-hook 'prog-mode-hook #'combobulate-mode))))

;; helper function: for emacs 29 or later
(defun crafted-ide-configure-tree-sitter (&optional opt-in-only)
  "Configure tree-sitter.

Requires a C compiler (gcc, cc, c99) installed on the system.
Note that OPT-IN-ONLY only affects setups with Emacs 29 or later.

For Emacs 29 or later:
Requires Emacs to be built using \"--with-tree-sitter\".
All language grammars are auto-installed unless they are a member
of OPT-IN-ONLY, in which case *only* those grammars are
installed."
  (crafted-ide--configure-tree-sitter opt-in-only))

;; require the "editorconfig" and the "ibuffer-project" for setups
(when (require 'editorconfig nil :noerror)
  (add-hook 'prog-mode-hook #'editorconfig-mode))
(when (require 'ibuffer-project nil :noerror)
  (defun crafted-ide-enhance-ibuffer-with-ibuffer-project ()
    "Set up integration for `ibuffer' with `ibuffer-project'."
    (setq ibuffer-filter-groups (ibuffer-project-generate-filter-groups))
    (unless (eq ibuffer-sorting-mode 'project-file-relative)
      (ibuffer-do-sort-by-project-file-relative)))
  (add-hook 'ibuffer-hook #'crafted-ide-enhance-ibuffer-with-ibuffer-project))

;; provide the necessary feature
(provide 'crafted-ide-config)
;;; crafted-ide-config.el ends here

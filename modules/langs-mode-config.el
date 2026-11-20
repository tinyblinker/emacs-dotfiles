;;; -*- lexical-binding: t -*-

;; bash
(add-to-list 'major-mode-remap-alist '(sh-mode . bash-ts-mode))

;; bash lsp
(with-eval-after-load 'eglot
  (add-to-list 'eglot-server-programs
               '((sh-mode bash-ts-mode) . ("bash-language-server" "start"))))

(add-hook 'sh-mode-hook #'eglot-ensure)
(add-hook 'bash-ts-mode-hook #'eglot-ensure)

;; bash format key
(with-eval-after-load 'sh-script
  (keymap-set bash-ts-mode-map "C-c C-f" #'eglot-format-buffer))

;; bash linter and formatter
(with-eval-after-load 'eglot
  (setq-default eglot-workspace-configuration
                (plist-put (default-value 'eglot-workspace-configuration)
                           :bashIde
                           '(:shellcheckPath "shellcheck"
                             :shfmt (:path "shfmt")))))

;; elisp format helper
(defun my/elisp-format-buffer ()
  "Format this elisp buffer"
  (interactive)
  (save-excursion
    (indent-region (point-min) (point-max))))

;; elisp format key
(with-eval-after-load 'elisp-mode
  (keymap-set emacs-lisp-mode-map "C-c C-f" #'my/elisp-format-buffer))

;; c and c++
(add-to-list 'major-mode-remap-alist '(c-mode . c-ts-mode))
(add-to-list 'major-mode-remap-alist '(c++-mode . c++-ts-mode))

;; c lsp, linter and formatter
(with-eval-after-load 'eglot
  (add-to-list 'eglot-server-programs
               '((c-mode c-ts-mode c++-mode c++-ts-mode)
                 . ("clangd"
                    "--enable-config"
                    "--clang-tidy"
                    "--fallback-style=LLVM"))))

(add-hook 'c-ts-mode-hook #'eglot-ensure)
(add-hook 'c++-ts-mode-hook #'eglot-ensure)

;; c format key
(with-eval-after-load 'c-ts-mode
  (keymap-set c-ts-mode-map "C-c C-f" #'eglot-format-buffer))

(with-eval-after-load 'c++-ts-mode
  (keymap-set c++-ts-mode-map "C-c C-f" #'eglot-format-buffer))

;; reject c-mode
(defun my/reject-c-mode ()
  (user-error "Please use 'c-ts-mode' instead of the 'c-mode'"))
(add-hook 'c-mode-hook #'my/reject-c-mode)

;; rust
(add-to-list 'major-mode-remap-alist '(rust-mode . rust-ts-mode))

;; rust lsp, linter and formatter
(with-eval-after-load 'eglot
  (add-to-list 'eglot-server-programs
               '((rust-ts-mode rust-mode)
                 . ("rust-analyzer"
                    :initializationOptions
                    (:check (:command "clippy")
                            :rustfmt (:overrideCommand ["rustfmt"]))))))

(add-hook 'rust-ts-mode-hook #'eglot-ensure)

;; cargo helpers
(defun my/rust-cargo (args)
  "Run cargo in the 'nearest' cargo 'root' dir with 'Cargo.toml'"
  (let ((default-directory
         (or (locate-dominating-file default-directory "Cargo.toml")
             default-directory)))
    (compile (concat "cargo " args))))
(defun my/rust-build ()
  (interactive)
  (my/rust-cargo "build"))
(defun my/rust-check ()
  (interactive)
  (my/rust-cargo "check"))
(defun my/rust-test ()
  (interactive)
  (my/rust-cargo "test"))
(defun my/rust-clippy ()
  (interactive)
  (my/rust-cargo "clippy"))

;; rust keys
(with-eval-after-load 'rust-ts-mode
  (keymap-set rust-ts-mode-map "C-c C-c C-u" #'my/rust-build)
  (keymap-set rust-ts-mode-map "C-c C-c C-k" #'my/rust-check)
  (keymap-set rust-ts-mode-map "C-c C-c C-t" #'my/rust-test)
  (keymap-set rust-ts-mode-map "C-c C-c C-l" #'my/rust-clippy)
  (keymap-set rust-ts-mode-map "C-c C-f" #'eglot-format-buffer))

;; reject rust-mode
(defun my/reject-rust-mode ()
  (user-error "Please use 'rust-ts-mode' instead of the 'rust-mode'"))
(add-hook 'rust-mode-hook #'my/reject-rust-mode)

(provide 'langs-mode-config)
;;; langs-mode-config.el ends here

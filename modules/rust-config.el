;;; -*- lexical-binding: t -*-

;; Make Emacs find the compiled Rust tree-sitter grammar in tree-sitter/
(setq treesit-extra-load-path
      (list (expand-file-name "tree-sitter" user-emacs-directory)))

;; The `rust-mode' package maps .rs to `rust-mode'; remap it to the
;; built-in tree-sitter `rust-ts-mode' instead.
(add-to-list 'major-mode-remap-alist '(rust-mode . rust-ts-mode))

;; Cargo commands (rust-compile/check/test/clippy/fmt) live in the
;; `rust-mode' package, not the built-in rust-ts-mode.
(use-package rust-mode
  :ensure t
  :bind (:map rust-ts-mode-map
              ("C-c C-c C-u" . rust-compile)
              ("C-c C-c C-k" . rust-check)
              ("C-c C-c C-t" . rust-test)
              ("C-c C-c C-l" . rust-run-clippy)
              ("C-c C-f" . rust-format-buffer)))

(provide 'rust-config)
;;; rust-config.el ends here

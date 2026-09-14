;;; -*- lexical-binding: t -*-

;; Rust tree-sitter grammar
(setq treesit-extra-load-path
      (list (expand-file-name "tree-sitter" user-emacs-directory)))

;; Remap rust-mode -> rust-ts-mode
(add-to-list 'major-mode-remap-alist '(rust-mode . rust-ts-mode))

;; Cargo commands (from rust-mode)
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

;;; -*- lexical-binding: t -*-

;; Rust tree-sitter grammar
(setq treesit-extra-load-path
      (list (expand-file-name "tree-sitter" user-emacs-directory)))

;; Remap rust-mode -> rust-ts-mode
(add-to-list 'major-mode-remap-alist '(rust-mode . rust-ts-mode))

;; Cargo commands (from rust-mode)
(use-package rust-mode
  :ensure t
  :commands (rust-compile rust-check rust-test rust-run-clippy rust-format-buffer))

;; Bind cargo keys as soon as rust-ts-mode loads
(with-eval-after-load 'rust-ts-mode
  (keymap-set rust-ts-mode-map "C-c C-c C-u" #'rust-compile)
  (keymap-set rust-ts-mode-map "C-c C-c C-k" #'rust-check)
  (keymap-set rust-ts-mode-map "C-c C-c C-t" #'rust-test)
  (keymap-set rust-ts-mode-map "C-c C-c C-l" #'rust-run-clippy)
  (keymap-set rust-ts-mode-map "C-c C-f" #'rust-format-buffer))

(provide 'rust-config)
;;; rust-config.el ends here

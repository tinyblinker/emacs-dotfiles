;;; -*- lexical-binding: t -*-

;; Remap 'rust-mode' to 'rust-ts-mode'
(add-to-list 'major-mode-remap-alist '(rust-mode . rust-ts-mode))

;; (unused?)
;; ;; Rust tree-sitter grammar
;; (setq treesit-extra-load-path
;;       (list (expand-file-name "tree-sitter" user-emacs-directory)))


;; ;; Cargo commands (from rust-mode)
;; (use-package rust-mode
;;   :ensure t
;;   :commands (rust-compile rust-check rust-test rust-run-clippy rust-format-buffer))

;; helper functions
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

;; Bind cargo keys as soon as rust-ts-mode loads
(with-eval-after-load 'rust-ts-mode
  (keymap-set rust-ts-mode-map "C-c C-c C-u" #'my/rust-build)
  (keymap-set rust-ts-mode-map "C-c C-c C-k" #'my/rust-check)
  (keymap-set rust-ts-mode-map "C-c C-c C-t" #'my/rust-test)
  (keymap-set rust-ts-mode-map "C-c C-c C-l" #'my/rust-clippy)
  (keymap-set rust-ts-mode-map "C-c C-f" #'eglot-format-buffer))

(provide 'rust-config)
;;; rust-config.el ends here

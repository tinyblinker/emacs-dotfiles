;;; -*- lexical-binding: t -*-
;; --Emacs Lisp--
;; helper functions(formatting)
(defun my/elisp-format-buffer ()
  "Format this elisp buffer"
  (interactive)
  (save-excursion
    (indent-region (point-min) (point-max))))

;; bind keys for elisp formatting
(with-eval-after-load 'elisp-mode
  (keymap-set emacs-lisp-mode-map "C-c C-f" #'my/elisp-format-buffer))

;; --C--
;; mode-remap('c-mode' remapped to the 'c-ts-mode')
(add-to-list 'major-mode-remap-alist '(c-mode . c-ts-mode))

;; ensure Eglot load after c-ts-mode
(add-hook 'c-ts-mode-hook #'eglot-ensure)

;; Do not load c-mode(throw an user error)
(defun my/reject-c-mode ()
  (user-error "Please use 'c-ts-mode' instead of the 'c-mode'"))
(add-hook 'c-mode-hook #'my/reject-c-mode)
(with-eval-after-load 'c-mode #'my/reject-c-mode)

;; let Eglot launch 'Clangd' in c-ts-mode
(with-eval-after-load 'eglot
  (add-to-list 'eglot-server-programs
               '(c-ts-mode . ("clangd"))))

;; keymaps in 'c-ts-mode'
(with-eval-after-load 'c-ts-mode
  (keymap-set c-ts-mode-map "C-c C-f" #'eglot-format-buffer))

;; --Rust--
;; Remap 'rust-mode' to 'rust-ts-mode'
(add-to-list 'major-mode-remap-alist '(rust-mode . rust-ts-mode))

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

(provide 'langs-mode-config)
;;; langs-mode-config.el ends here

;;; -*- lexical-binding: t -*-

;; Cargo commands: build/check/test/clippy/format bound under C-c C-c and C-c C-f
(use-package rust-ts-mode
  :ensure t
  :bind (:map rust-ts-mode-map
              ("C-c C-c C-u" . #'rust-compile)
              ("C-c C-c C-k" . #'rust-check)
              ("C-c C-c C-t" . #'rust-test)
              ("C-c C-c C-l" . #'rust-run-clippy)
              ("C-c C-f" . #'rust-format-buffer)))

(provide 'rust-config)
;;; rust-config.el ends here

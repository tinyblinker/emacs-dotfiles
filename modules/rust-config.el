;;; -*- lexical-binding: t -*-

(use-package rust-mode
  :ensure t
  :after rust-ts-mode
  :bind (:map rust-ts-mode-map
              ("C-c C-c C-u" . #'rust-compile)
              ("C-c C-c C-k" . #'rust-check)
              ("C-c C-c C-t" . #'rust-test)
              ("C-c C-c C-l" . #'rust-run-clippy)
              ("C-c C-f" . #'rust-format-buffer)))

(provide 'rust-config)
;;; rust-config.el ends here

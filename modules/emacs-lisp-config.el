;;; -*- lexical-binding: t -*-

;; helper functions(formatting)
(defun my/elisp-format-buffer ()
  "Format this elisp buffer"
  (interactive)
  (save-excursion
    (indent-region (point-min) (point-max))))

;; bind keys for elisp formatting
(with-eval-after-load 'elisp-mode
  (keymap-set emacs-lisp-mode-map "C-c C-f" #'my/elisp-format-buffer))

(provide 'emacs-lisp-config)
;;; emacs-lisp-config.el ends here

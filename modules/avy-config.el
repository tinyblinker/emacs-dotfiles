;;; -*- lexical-binding: t -*-

;; Jump to visible text
(use-package avy
  :ensure t
  :bind (("M-g c" . avy-goto-char-timer)  ;; goto char
         ("M-g l" . avy-goto-line)))      ;; goto line

(provide 'avy-config)
;;; avy-config.el ends here

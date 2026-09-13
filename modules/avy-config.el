;;; -*- lexical-binding: t -*-

;; Avy: jump to visible text via overlay labels
;; (simulates neovim's flash.nvim)
(use-package avy
  :ensure t
  :bind (("M-g c" . avy-goto-char-timer)  ;; type a char, labels appear
         ("M-g l" . avy-goto-line)))      ;; jump to a visible line

(provide 'avy-config)
;;; avy-config.el ends here

;;; -*- lexical-binding: t -*-

;; Search & navigation
(use-package consult
  :ensure t
  :bind (;; diagnostics
         ("C-c q" . consult-flymake)
         ;; buffers & files
         ("C-x b" . consult-buffer)      ;; switch buffers
         ("M-s l" . consult-line)        ;; search buffer
         ("M-s g" . consult-ripgrep)     ;; grep project
         ("M-s r" . consult-history)     ;; history
         ("M-g g" . consult-goto-line)
         ("M-g i" . consult-imenu)       ;; imenu
         ("M-y" . consult-yank-pop))     ;; yank ring
  :custom
  (consult-narrow-key "<")  ;; narrow with <
  :init
  ;; xref preview
  (setq xref-show-xrefs-function #'consult-xref
        xref-show-definitions-function #'consult-xref)
  ;; project in mode-line
  (setq project-mode-line t))

(provide 'consult-config)
;;; consult-config.el ends here

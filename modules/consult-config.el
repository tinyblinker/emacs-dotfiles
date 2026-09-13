;;; -*- lexical-binding: t -*-

;; Consult: interactive search/navigation commands
;; (the telescope.nvim replacement, with fuzzy + live preview)
(use-package consult
  :ensure t
  :bind (;; diagnostics: list all errors/warnings/hints (simulates <leader>q)
         ("C-c q" . consult-flymake)
         ;; buffer/file navigation
         ("C-x b" . consult-buffer)      ;; fuzzy switch among buffers & files
         ("M-s l" . consult-line)        ;; fuzzy search within current buffer
         ("M-s g" . consult-ripgrep)     ;; live grep across the project
         ("M-s r" . consult-history)     ;; restore previous minibuffer/search history
         ("M-g g" . consult-goto-line)
         ("M-g i" . consult-imenu)       ;; outline/imenu navigation
         ("M-y" . consult-yank-pop))     ;; fuzzy yank from the kill ring
  :custom
  (consult-narrow-key "<")  ;; narrow candidates with "<category"
  :init
  ;; fuzzy preview for xref results (goto definition/references)
  (setq xref-show-xrefs-function #'consult-xref
        xref-show-definitions-function #'consult-xref)
  ;; show the current project name in the mode line
  (setq project-mode-line t))

(provide 'consult-config)
;;; consult-config.el ends here

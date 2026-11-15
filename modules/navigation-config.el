;;; -*- lexical-binding: t -*-
(use-package multiple-cursors
  :ensure t
  :demand t
  :bind (("C-S-c C-S-c" . 'mc/edit-lines)
         ("C->" . 'mc/mark-next-like-this)
         ("C-<" . 'mc/mark-previous-like-this)
         ("C-c C-<" . 'mc/mark-all-like-this)))


(use-package symbol-overlay
  :ensure t
  :hook (prog-mode . symbol-overlay-mode)
  :bind (:map symbol-overlay-mode-map
              ("M-p" . symbol-overlay-jump-prev)
              ("M-n" . symbol-overlay-jump-next)))

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

(use-package consult-eglot
  :ensure t
  :after (consult eglot)
  :bind (:map eglot-mode-map
              ("C-c l s" . consult-eglot-symbols)))

(use-package embark
  :ensure t
  :bind (("C-." . embark-act)      ;; act on target
         ("C-;" . embark-dwim))    ;; dwim
  :init
  (setq prefix-help-command #'embark-prefix-help-command)
  :config
  (add-hook 'eldoc-documentation-functions #'embark-eldoc-first-target))

(use-package embark-consult
  :ensure t
  :after (embark consult)
  :hook (embark-collect-mode . consult-preview-at-point-mode))

(use-package avy
  :ensure t
  :bind (("M-g c" . avy-goto-char-timer)  ;; goto char
         ("M-g l" . avy-goto-line)))      ;; goto line

(use-package better-jumper
  :ensure t
  :demand t                          ;; start on boot
  :bind (("C-c j b" . better-jumper-jump-backward)
         ("C-c j f" . better-jumper-jump-forward))
  :config
  (better-jumper-mode 1)
  ;; Non-interactive advice wrapper
  (defun my-better-jumper-set-jump-advice (&rest _)
    (better-jumper-set-jump))
  ;; Record jumps on navigation
  (dolist (cmd '(set-mark-command pop-to-mark-command imenu
                                  xref-find-definitions xref-find-references
                                  xref-go-back xref-go-forward))
    (advice-add cmd :before #'my-better-jumper-set-jump-advice))
  (with-eval-after-load 'consult
    (dolist (cmd '(consult-imenu consult-goto-line consult-line
                                 consult-ripgrep consult-buffer consult-flymake))
      (advice-add cmd :before #'my-better-jumper-set-jump-advice)))
  (with-eval-after-load 'consult-eglot
    (advice-add 'consult-eglot-symbols :before #'my-better-jumper-set-jump-advice))
  (with-eval-after-load 'avy
    (dolist (cmd '(avy-goto-char-timer avy-goto-line))
      (advice-add cmd :before #'my-better-jumper-set-jump-advice)))
  (with-eval-after-load 'org-roam
    (advice-add 'org-roam-node-find :before #'my-better-jumper-set-jump-advice)))

(provide 'navigation-config)
;;; navigation-config.el ends here

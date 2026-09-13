;;; -*- lexical-binding: t -*-

;; Better-jumper: jump-list navigation across buffer positions.
(use-package better-jumper
  :ensure t
  :demand t                          ;; enable at startup, not on first keypress
  :bind (("C-c j b" . better-jumper-jump-backward)
         ("C-c j f" . better-jumper-jump-forward))
  :config
  (better-jumper-mode 1)
  ;; better-jumper does NOT record jumps on its own (only evil users get
  ;; that via `evil-set-jump'); advise the navigation commands that should
  ;; leave a jump marker so C-c j b/f can go back/forward.
  (dolist (cmd '(set-mark-command pop-to-mark-command imenu
                 xref-find-definitions xref-find-references
                 xref-go-back xref-go-forward))
    (advice-add cmd :before #'better-jumper-set-jump))
  (with-eval-after-load 'consult
    (dolist (cmd '(consult-imenu consult-goto-line consult-line
                   consult-ripgrep consult-buffer consult-flymake))
      (advice-add cmd :before #'better-jumper-set-jump)))
  (with-eval-after-load 'consult-eglot
    (advice-add 'consult-eglot-symbols :before #'better-jumper-set-jump))
  (with-eval-after-load 'avy
    (dolist (cmd '(avy-goto-char-timer avy-goto-line))
      (advice-add cmd :before #'better-jumper-set-jump)))
  (with-eval-after-load 'org-roam
    (advice-add 'org-roam-node-find :before #'better-jumper-set-jump)))

(provide 'better-jumper-config)
;;; better-jumper-config.el ends here

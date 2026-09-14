;;; -*- lexical-binding: t -*-

;; Better-jumper: jump-list navigation across buffer positions.
(use-package better-jumper
  :ensure t
  :demand t                          ;; enable at startup, not on first keypress
  :bind (("C-c j b" . better-jumper-jump-backward)
         ("C-c j f" . better-jumper-jump-forward))
  :config
  (better-jumper-mode 1)
  ;; Non-interactive wrapper.  Advising commands with `better-jumper-set-jump'
  ;; (which is itself interactive, `(interactive)') makes Emacs merge the
  ;; interactive specs and drop the advised command's own prefix-arg spec,
  ;; e.g. turning `set-mark-command''s `(interactive P)' into `(interactive
  ;; nil)'.  Since Emacs 30+ `set-mark-command'/`imenu' take a mandatory ARG,
  ;; that yields `wrong-number-of-arguments'.  A non-interactive advice keeps
  ;; the original command's interactive form intact.
  (defun my-better-jumper-set-jump-advice (&rest _)
    (better-jumper-set-jump))
  ;; better-jumper does NOT record jumps on its own (only evil users get
  ;; that via `evil-set-jump'); advise the navigation commands that should
  ;; leave a jump marker so C-c j b/f can go back/forward.
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

(provide 'better-jumper-config)
;;; better-jumper-config.el ends here

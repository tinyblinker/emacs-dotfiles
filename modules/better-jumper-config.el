;;; -*- lexical-binding: t -*-

;; Jump list
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

(provide 'better-jumper-config)
;;; better-jumper-config.el ends here

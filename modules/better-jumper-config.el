;;; -*- lexical-binding: t -*-

;; Better-jumper: jump-list navigation across buffer positions
;; (simulates neovim's C-o / C-i). Note: C-i == TAB in Emacs, so the
;; forward jump is bound to C-M-o.
(use-package better-jumper
  :ensure t
  :bind (("C-o" . better-jumper-jump-backward)
         ("C-M-o" . better-jumper-jump-forward))
  :config
  (better-jumper-mode 1))

(provide 'better-jumper-config)
;;; better-jumper-config.el ends here

;;; -*- lexical-binding: t -*-

;; Nerd-icons family: icon fonts for completion, corfu, ibuffer, marginalia.
;; (Dirvish renders its own icons via its `nerd-icons' attribute, so we do NOT
;; enable nerd-icons-dired here -- that would show every entry's icon twice.)

;; Core icon library (used by dirvish's `nerd-icons' attribute and the
;; nerd-icons-* frontends below)
(use-package nerd-icons
  :ensure t)

;; Annotate marginalia candidates with icons
(use-package nerd-icons-completion
  :ensure t
  :after marginalia
  :config
  (nerd-icons-completion-mode 1)
  (add-hook 'marginalia-mode-hook #'nerd-icons-completion-marginalia-setup))

;; Show icons in corfu completion popups
(use-package nerd-icons-corfu
  :ensure t
  :after corfu
  :config
  (add-to-list 'corfu-margin-formatters #'nerd-icons-corfu-formatter))

;; Show icons in ibuffer listings
(use-package nerd-icons-ibuffer
  :ensure t
  :hook (ibuffer-mode . nerd-icons-ibuffer-mode))

(provide 'nerd-icons-config)
;;; nerd-icons-config.el ends here

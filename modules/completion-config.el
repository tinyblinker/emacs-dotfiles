;;; -*- lexical-binding: t; -*-

(setq tab-always-indent 'complete
      completion-cycle-threshold 3
      completions-detailed t
      xref-show-definitions-function #'xref-show-definitions-completing-read)

(use-package completion-preview
  :config
  (global-completion-preview-mode -1)
  :bind (:map completion-preview-active-mode-map
              ("M-n" . completion-preview-next-candidate)
              ("M-p" . completion-preview-prev-candidate)))

(use-package vertico
  :ensure t
  :custom (vertico-cycle t)
  :config
  (vertico-mode 1)
  (fido-mode -1)
  (fido-vertical-mode -1)
  (icomplete-mode -1)
  (icomplete-vertical-mode -1))

;; config "marginalia": show docs(more info) in "vertico" completions list 
(use-package marginalia
  :ensure t
  :after vertico
  :config (marginalia-mode 1))

;; config "orderless": with fuzzel algorithm supporrt
(use-package orderless
  :ensure t
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles . (partial-completion))))))

;; config "consult": (with magic command and RT preview) enhanced search and navigation
(use-package consult
  :ensure t
  :bind (("C-s" . consult-line)
         :map minibuffer-local-map
         ("C-r" . consult-history))
  :init
  (setq completion-in-region-function #'consult-completion-in-region))

;; config "corfu": completion ui in buffers
(use-package corfu
  :ensure t
  :custom
  (corfu-cycle t)
  (corfu-auto t)
  (corfu-auto-prefix 2)
  :config (global-corfu-mode 1))

(use-package corfu-terminal
  :ensure t
  :if (not (display-graphic-p))
  :after corfu
  :config (corfu-terminal-mode +1))

(use-package cape
  :ensure t
  :config
  (add-to-list 'completion-at-point-functions #'cape-file)
  (add-to-list 'completion-at-point-functions #'cape-dabbrev))

;; add icon to corfu
(use-package kind-icon
  :ensure t
  :after corfu
  :custom
  (kind-icon-blend-background t)
  (kind-icon-default-face 'corfu-default) ; only needed with blend-background
  :config
  (add-to-list 'corfu-margin-formatters #'kind-icon-margin-formatter))

(provide 'completion-config)
;;; completion-config.el ends here

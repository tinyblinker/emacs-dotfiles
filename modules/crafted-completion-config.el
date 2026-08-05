;;; -*- lexical-binding: t; -*-

;; config "vertico": minibuffer vertical layout
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
  :config
  (global-completion-preview-mode -1)
  (global-corfu-mode 1))

(use-package corfu-terminal
  :ensure t
  :if (not (display-graphic-p))
  :after corfu
  :config (corfu-terminal-mode +1))

;; provide the necessary feature
(provide 'crafted-completion-config)
;;; crafted-completion.el ends here

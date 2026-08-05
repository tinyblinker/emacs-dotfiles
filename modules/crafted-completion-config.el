;;; -*- lexical-binding: t; -*-

;; config "vertico": minibuffer vertical layout
(use-package vertico
  :ensure t
  :demand t
  :custom (vertico-cycle t)
  :config
  (vertico-mode 1)
  (with-eval-after-load 'crafted-defaults-config
    (fido-mode -1)
    (fido-vertical-mode -1)
    (icomplete-mode -1)
    (icomplete-vertical-mode -1))))

;; config "marginalia": show docs(more info) in "vertico" completions list 
(use-package marginalia
:ensure t
:after vertico
:config (marginalia-mode 1))

;; config "consult": (with magic command and RT preview) enhanced search and navigation
(use-package consult
  :ensure t
  :demand t
  :bind (("C-s" . consult-line)
         :map minibuffer-local-map
         ("C-r" . consult-history))
  :init
  (setq completion-in-region-function #'consult-completion-in-region))

;; config "orderless": with fuzzel algorithm supporrt
(use-package orderless
  :ensure t
  :demand t
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles . (partial-completion))))))

;; config "embark": show more thing in candidates
(use-package embark
  :ensure t
  :demand t
  :bind
  ("<remap> <describe-bindings>" . embark-bindings)
  ("C-." . embark-act)
  :init
  (setq prefix-help-command #'embark-prefix-help-command))

;; config "embark-consult": use consult when embark activated
(use-package embark-consult
  :ensure t
  :after (embark consult)
  :hook
  (embark-collect-mode-hook . consult-preview-at-point-mode))

;; config "corfu": completion ui in buffers
(use-package corfu
  :ensure t
  :demand t
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

(use-package corfu-popupinfo
  :after corfu
  :config
  (corfu-popupinfo-mode 1)
  (eldoc-add-command #'corfu-insert)
  :bind(:map corfu-map
             ("M-p" . corfu-popupinfo-scroll-down)
             ("M-n" . corfu-popupinfo-scroll-up)
             ("M-d" . corfu-popupinfo-toggle)))

;; config "cape": like friendly snniper in neovim
(use-package cape
  :ensure t
  :after corfu
  :init
  (defun crafted-completion-corfu-eshell ()
    "Special settings for when using corfu with eshell."
    (setq-local corfu-quit-at-boundary t
                corfu-quit-no-match t
                corfu-auto nil)
    (corfu-mode))
  :config
  (add-to-list 'completion-at-point-functions #'cape-file)
  (add-to-list 'completion-at-point-functions #'cape-dabbrev)
  (advice-add 'pcomplete-completions-at-point :around #'cape-wrap-silent)
  :hook
  (eshell . crafted-completion-corfu-eshell))

;; provide the necessary feature
(provide 'crafted-completion-config)
;;; crafted-completion.el ends here

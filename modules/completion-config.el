;;; -*- lexical-binding: t; -*-

(setq tab-always-indent 'complete
      completion-cycle-threshold 3
      completions-detailed t
      completions-format 'vertical
      xref-show-definitions-function #'xref-show-definitions-completing-read
      completion-styles '(flex basic)
      completion-category-overrides '((file (styles . (partial-completion)))))

;; Emacs 30 built-in ghost-text completion preview
(use-package completion-preview
  :config
  (global-completion-preview-mode 1)
  :bind (:map completion-preview-active-mode-map
              ("M-n" . completion-preview-next-candidate)
              ("M-p" . completion-preview-prev-candidate)))

;; Vertical minibuffer completion UI (replaces Vertico)
(icomplete-vertical-mode 1)

;; config "corfu": in-buffer popup completion UI
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

(provide 'completion-config)
;;; completion-config.el ends here

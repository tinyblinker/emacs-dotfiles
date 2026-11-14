;;; -*- lexical-binding: t -*-

;; Completion defaults
(setq tab-always-indent 'complete   ;; Tab: indent or complete
      completions-format 'vertical) ;; vertical list

;; In-buffer popup completion
(use-package corfu
  :ensure t
  :custom
  (corfu-cycle t)                ;; wrap around
  (corfu-auto t)                 ;; auto popup
  (corfu-auto-prefix 2)          ;; after 2 chars
  (corfu-auto-delay 0.2)         ;; 0.2s delay
  (corfu-preselect 'prompt)      ;; preselect first
  (corfu-quit-no-match 'separator) ;; quit on no match
  (corfu-on-exact-match 'insert) ;; insert on exact
  :config
  (global-corfu-mode 1)
  (corfu-history-mode 1)    ;; history
  (corfu-popupinfo-mode 1)  ;; doc popup
  (corfu-echo-mode 1)       ;; echo info
  (corfu-indexed-mode 1))   ;; index numbers

;; Extra completion backends
(use-package cape
  :ensure t
  :bind ("C-c p" . cape-prefix-map) ;; cape prefix map
  :init
  (add-hook 'completion-at-point-functions #'cape-dabbrev)     ;; dabbrev
  (add-hook 'completion-at-point-functions #'cape-file)        ;; files
  (add-hook 'completion-at-point-functions #'cape-keyword)     ;; keywords
  (add-hook 'completion-at-point-functions #'cape-elisp-block)) ;; elisp

;; Fuzzy matching
(use-package orderless
  :ensure t
  :custom
  (orderless-matching-styles '(orderless-flex))
  ;; orderless + basic fallback
  (completion-styles '(orderless basic))
  (completion-category-defaults nil)
  (completion-category-overrides '((file (styles basic partial-completion)))))

;; Core icon library
(use-package nerd-icons
  :ensure t)

;; Icons in marginalia
(use-package nerd-icons-completion
  :ensure t
  :after marginalia
  :config
  (nerd-icons-completion-mode 1)
  (add-hook 'marginalia-mode-hook #'nerd-icons-completion-marginalia-setup))

;; Icons in corfu
(use-package nerd-icons-corfu
  :ensure t
  :after corfu
  :config
  (add-to-list 'corfu-margin-formatters #'nerd-icons-corfu-formatter))

;; Icons in ibuffer
(use-package nerd-icons-ibuffer
  :ensure t
  :hook (ibuffer-mode . nerd-icons-ibuffer-mode))

(provide 'completion-config)
;;; completion-config.el ends here

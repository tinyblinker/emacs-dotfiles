;;; -*- lexical-binding: t -*-

;; Contextual actions
(use-package embark
  :ensure t
  :bind (("C-." . embark-act)      ;; act on target
         ("C-;" . embark-dwim))    ;; dwim
  :init
  (setq prefix-help-command #'embark-prefix-help-command)
  :config
  (add-hook 'eldoc-documentation-functions #'embark-eldoc-first-target))

;; Live preview via consult
(use-package embark-consult
  :ensure t
  :after (embark consult)
  :hook (embark-collect-mode . consult-preview-at-point-mode))

(provide 'embark-config)
;;; embark-config.el ends here

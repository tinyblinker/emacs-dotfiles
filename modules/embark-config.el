;;; -*- lexical-binding: t -*-

;; Embark: contextual actions on completion candidates and things at point
(use-package embark
  :ensure t
  :bind (("C-." . embark-act)      ;; act on the target at point
         ("C-;" . embark-dwim))    ;; do the most reasonable thing
  :init
  (setq prefix-help-command #'embark-prefix-help-command)
  :config
  (add-hook 'eldoc-documentation-functions #'embark-eldoc-first-target))

;; Embark-consult: live preview of embark-collect via consult
(use-package embark-consult
  :ensure t
  :after (embark consult)
  :hook (embark-collect-mode . consult-preview-at-point-mode))

(provide 'embark-config)
;;; embark-config.el ends here

;;; -*- lexical-binding: t -*-

;; Fuzzy matching
(use-package orderless
  :ensure t
  :defer 1
  :custom
  (orderless-matching-styles '(orderless-flex))
  ;; orderless + basic fallback
  (completion-styles '(orderless basic))
  (completion-category-defaults nil)
  (completion-category-overrides '((file (styles basic partial-completion)))))

(provide 'orderless-config)
;;; orderless-config.el ends here

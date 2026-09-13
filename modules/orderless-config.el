;;; -*- lexical-binding: t -*-

;; Orderless: flexible out-of-order fuzzy matching for completion candidates
(use-package orderless
  :ensure t
  :defer 1
  :custom
  (orderless-matching-styles '(orderless-flex))
  ;; orderless as the primary completion style, basic as fallback
  (completion-styles '(orderless basic))
  (completion-category-defaults nil)
  (completion-category-overrides '((file (styles basic partial-completion)))))

(provide 'orderless-config)
;;; orderless-config.el ends here

;;; -*- lexical-binding: t -*-

;;; Orderless: match space-separated pattern fragments in any order
;;;
;;; Traditional completion matches a prefix. Orderless matches fragments:
;;;   "fix buf" → fix-buffer    (two fragments, any order)
;;;   "get fi"  → get-file      (literal match)
;;;   "m d f"   → make-directory (initialism match)
;;;
;;; Per-component style overrides via affix characters (built-in default):
;;;   !negate   =exact   ~fuzzy   ,initialism   ^prefix   %ignore-case   &annotation
(use-package orderless
  :ensure t
  :custom
  (completion-styles '(orderless basic))    ;; Primary: orderless, fallback: basic
  (completion-category-overrides '((file (styles partial-completion)))) ;; Wildcard paths & TRAMP
  (orderless-component-separator 'orderless-escapable-split) ;; Space-separated, \  for literal space
  (orderless-matching-styles '(orderless-literal orderless-regexp)) ;; Literal first, then regexp
  (orderless-smart-case t))                 ;; Case-sensitive only when you type uppercase

(provide 'orderless-config)
;;; orderless-config.el ends here

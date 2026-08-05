;;; -*- lexical-binding: t -*-

;; disable auto-pair in the "org-mode"
(use-package electric-pair
  :hook
  (org-mode . org-enhance-electric-pair-inhibit-predicate)
  (electric-pair-mode-hook . org-enhance-electric-pair-inhibit-predicate)
  :config
  (defun org-enhance-electric-pair-inhibit-predicate ()
    "Disable auto-pairing of \"<\" in `org-mode' when using `electric-pair-mode'."
    (when (and electric-pair-mode (eql major-mode #'org-mode))
      (setq-local electric-pair-inhibit-predicate
                  `(lambda (c)
                     (if (char-equal c ?<)
                         t
                       (,electric-pair-inhibit-predicate c)))))))

;; Config denote
(use-package denote
  :ensure t)

;; Config the org-mode
(use-package org
  :custom
  (org-return-follows-link t)
  (org-mouse-1-follows-link t)
  (org-link-descriptive t)
  (org-hide-emphasis-markers t)
  :hook (org-mode . org-indent-mode))

(provide 'org-config)
;;; org-config.el ends here

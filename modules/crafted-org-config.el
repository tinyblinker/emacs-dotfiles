;;; crafted-org-config.el --- Crafted Org Config  -*- lexical-binding: t; -*-

;; Copyright (C) 2022
;; SPDX-License-Identifier: MIT

;; Author: System Crafters Community

;;; Code:

(customize-set-variable 'org-return-follows-link t)
(customize-set-variable 'org-mouse-1-follows-link t)

(customize-set-variable 'org-link-descriptive t)

(add-hook 'org-mode-hook #'org-indent-mode)

(customize-set-variable 'org-hide-emphasis-markers t)
(when (locate-library "org-appear")
  (add-hook 'org-mode-hook 'org-appear-mode))

(defun crafted-org-enhance-electric-pair-inhibit-predicate ()
  "Disable auto-pairing of \"<\" in `org-mode' when using `electric-pair-mode'."
  (when (and electric-pair-mode (eql major-mode #'org-mode))
    (setq-local electric-pair-inhibit-predicate
                `(lambda (c)
                   (if (char-equal c ?<)
                       t
                     (,electric-pair-inhibit-predicate c))))))

(add-hook 'electric-pair-mode-hook #'crafted-org-enhance-electric-pair-inhibit-predicate)
(add-hook 'org-mode-hook #'crafted-org-enhance-electric-pair-inhibit-predicate)

(provide 'crafted-org-config)
;;; crafted-org-config.el ends here

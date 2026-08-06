;;; -*- lexical-binding: t -*-

;; Disable auto-pairing of "<" in org-mode (avoids accidental timestamps)
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

;; Denote: structured note-taking with consistent file naming
(use-package denote
  :ensure t
  :hook (dired-mode . denote-dired-mode)
  :bind (("C-c n n" . denote)
         ("C-c n r" . denote-rename-file)
         ("C-c n l" . denote-link)
         ("C-c n b" . denote-backlinks)
         ("C-c n g" . denote-grep)
         ("C-c n d" . denote-dired))
  :custom
  (denote-directory (expand-file-name "~/Documents/notes/"))
  (denote-prompts '(title keywords))
  (denote-sort-keywords t)
  (denote-infer-keywords t)
  :config
  (denote-rename-buffer-mode 1))

;; Org-mode: clickable links, hidden markup, indented headings
(use-package org
  :custom
  (org-return-follows-link t)
  (org-mouse-1-follows-link t)
  (org-link-descriptive t)
  (org-hide-emphasis-markers t)
  :hook (org-mode . org-indent-mode))

(provide 'org-config)
;;; org-config.el ends here

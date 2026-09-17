;;; -*- lexical-binding: t -*-

;; Org-mode
(use-package org
  :defer t
  :custom
  (org-hide-emphasis-markers t) ;; hide markup
  (org-startup-indented t)      ;; indent
  (org-log-into-drawer t) ;; log into drawer
  (org-pretty-entities t) ;; pretty entities
  ;; agenda/capture keys
  :bind (("C-c a" . org-agenda)
         ("C-c c" . org-capture))
  :config
  (setq org-directory (expand-file-name "org/capture/" user-emacs-directory))
  (setq org-agenda-files `(,org-directory))
  (setq org-use-sub-superscripts nil)

  ;; add timestamp when the TODO changed to "done"
  (setq org-log-done 'time)
  
  ;; mkdir if missing
  (unless (file-directory-p org-directory)
    (make-directory org-directory t))

  ;; Capture templates
  (setq org-capture-templates
        '(("t" "Todo" entry
           (file "inbox.org")
           "* TODO %?\n  %U\n  %a")
          ("n" "Note" entry
           (file "capture-notes.org")
           "* %?\n  %U\n  %a")))

  ;; TODO workflow
  (setq org-todo-keywords
        '((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d)")))

  ;; Structure templates
  (require 'org-tempo)

  ;; Stable links via org-id
  (require 'org-id)
  (setq org-id-link-to-org-use-id 'create-if-interactive-and-no-custom-id)

  ;; Preview LaTeX on open
  (setq org-startup-with-latex-preview t)

  ;; LaTeX backend + scale
  (setq org-preview-latex-default-process 'dvisvgm)
  (setq org-format-latex-options
        (plist-put org-format-latex-options :scale 1.5)))

(provide 'org-config)
;;; org-config.el ends here

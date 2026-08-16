;;; -*- lexical-binding: t -*-

;; Org-mode: note-taking, task management, agenda, and capture
(use-package org
  :defer t
  :custom
  (org-hide-emphasis-markers t)         ;; Hide */_~= markup, show styled text only
  (org-startup-indented t)              ;; Turn on org-indent-mode at startup
  (org-log-into-drawer t)               ;; File state change notes into LOGBOOK drawer
  (org-pretty-entities t)               ;; Display \alpha etc. as Unicode characters
  ;; Global keybindings for agenda and capture
  :bind (("C-c a" . org-agenda)
         ("C-c c" . org-capture))
  :config
  (setq org-directory (expand-file-name "org/" user-emacs-directory))
  (setq org-agenda-files `(,org-directory))
  (setq org-use-sub-superscripts nil)

  ;; Create files and dirs if not exists
  (unless (file-directory-p org-directory)
    (make-directory org-directory t))

  ;; Capture templates for quick todo and note entries
  (setq org-capture-templates
        '(("t" "Todo" entry
           (file "inbox.org")
           "* TODO %?\n  %U\n  %a")
          ("n" "Note" entry
           (file "capture-notes.org")
           "* %?\n  %U\n  %a")))

  ;; TODO workflow states: TODO -> NEXT -> DONE
  (setq org-todo-keywords
        '((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d)")))

  ;; Enable built-in structure templates (<s TAB, <e TAB, etc.)
  (require 'org-tempo)

  ;; Enable org-id for stable cross-reference links; create an ID when inserting a link interactively
  (require 'org-id)
  (setq org-id-link-to-org-use-id 'create-if-interactive-and-no-custom-id))

;; add mermaid support for org-mode
(use-package ob-mermaid
  :ensure t
  :after org
  :config
  (add-to-list 'org-babel-tangle-lang-exts '("mermaid" . "mmd")))

;; add ox-gfm for modern markdown export
(use-package ox-gfm
  :ensure t
  :config
  (eval-after-load "org"
    '(require 'ox-gfm nil t)))

(provide 'org-config)
;;; org-config.el ends here

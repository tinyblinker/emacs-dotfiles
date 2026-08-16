;;; -*- lexical-binding: t -*-

;; Disable auto-pairing of "<" in org-mode (avoids accidental timestamps)
(use-package elec-pair
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

;; Org-mode: note-taking, task management, agenda, and capture
;; Defer org — it auto-loads when opening a .org file or pressing C-c a / C-c c.
;; Org is a massive package; deferring it cuts startup time significantly.
(use-package org
  :defer t
  :custom
  (org-return-follows-link t)           ;; Enter key opens links at point
  (org-mouse-1-follows-link t)          ;; Single mouse click opens links
  (org-hide-emphasis-markers t)         ;; Hide */_~= markup, show styled text only
  (org-startup-indented t)              ;; Turn on org-indent-mode at startup
  (org-log-into-drawer t)               ;; File state change notes into LOGBOOK drawer
  (org-ellipsis " ⮵")                   ;; Custom ellipsis for folded headings
  (org-fontify-whole-heading-line t)    ;; Apply heading face to the entire line, not just text
  (org-fontify-quote-and-verse-blocks t) ;; Apply special face to quote and verse blocks
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

(provide 'org-config)
;;; org-config.el ends here

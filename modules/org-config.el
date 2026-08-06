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
  (denote-directory (expand-file-name "notes/" user-emacs-directory))
  (denote-prompts '(title keywords))
  (denote-sort-keywords t)
  (denote-infer-keywords t)
  :config
  (denote-rename-buffer-mode 1))

;; Org-mode: note-taking, task management, agenda, and capture
(use-package org
  ;; Basic appearance and link behavior
  :custom
  (org-return-follows-link t)
  (org-mouse-1-follows-link t)
  (org-link-descriptive t)
  (org-hide-emphasis-markers t)
  (org-startup-indented t)
  ;; Log state changes into a LOGBOOK drawer
  (org-log-into-drawer t)
  ;; Use a nicer ellipsis symbol for folded headings
  (org-ellipsis " ⮵")
  ;; Fontify entire heading line and done headlines
  (org-fontify-whole-heading-line t)
  (org-fontify-done-headline t)
  (org-fontify-quote-and-verse-blocks t)
  (org-pretty-entities t)
  ;; Indent content under headings
  :hook (org-mode . org-indent-mode)
  ;; Global keybindings for agenda and capture
  :bind (("C-c a" . org-agenda)
         ("C-c c" . org-capture))
  :config
  ;; Set org directory inside the Emacs config tree
  (setq org-directory (expand-file-name "org/" user-emacs-directory))
  (setq org-default-notes-file (expand-file-name "inbox.org" org-directory))
  (setq org-agenda-files `(,org-directory))

  ;; Create org-directory and default files if missing
  (unless (file-directory-p org-directory)
    (make-directory org-directory t))

  (dolist (file '("inbox.org" "notes.org"))
    (let ((filepath (expand-file-name file org-directory)))
      (unless (file-exists-p filepath)
        (with-temp-buffer
          (write-file filepath)))))

  ;; Capture templates for quick todo and note entries
  (setq org-capture-templates
        '(("t" "Todo" entry
           (file "inbox.org")
           "* TODO %?\n  %U\n  %a")
          ("n" "Note" entry
           (file "notes.org")
           "* %?\n  %U\n  %a")))

  ;; TODO workflow states: TODO -> NEXT -> DONE
  (setq org-todo-keywords
        '((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d)")))

  ;; Enable built-in structure templates (<s TAB, <e TAB, etc.)
  (require 'org-tempo)

  ;; Enable org-id for stable cross-reference links between notes
  (require 'org-id)
  (setq org-id-link-to-org-use-id 'create-if-interactive-and-no-custom-id))

(provide 'org-config)
;;; org-config.el ends here

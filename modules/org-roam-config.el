;;; -*- lexical-binding: t -*-

;;; Org-roam: networked note-taking with automatic backlinks and graph visualization
;;;
;;; Defer org-roam — it only loads when you press C-c n ... or open a notes/ file.
;;; Uses the notes/ directory under the Emacs config. On first use, the SQLite
;;; database indexes all existing .org files in that directory, picking up any
;;; notes from previous setups (e.g., denote) automatically.
(use-package org-roam
  :ensure t
  :defer t
  :bind (("C-c n f" . org-roam-node-find) ;; Find or create a note by title
         ("C-c n i" . org-roam-node-insert) ;; Insert a link to an existing note at point
         ("C-c n l" . org-roam-buffer-toggle) ;; Toggle the backlinks sidebar for the current note
         ("C-c n g" . org-roam-graph) ;; Show an interactive graph of note connections
         ("C-c n t" . org-roam-tag-add) ;; Add a tag to the current note
         ("C-c n a" . org-roam-alias-add) ;; Add an alias (alternate title) to the note
         ("C-M-i" . completion-at-point));;trigger the completion
  :custom
  ;; Store all Org-roam notes in the notes/ directory under the Emacs config.
  ;; file-truename resolves symlinks so the database stores canonical paths.
  (org-roam-directory (file-truename (expand-file-name "notes/" user-emacs-directory)))
  ;; Capture template for new notes: creates a file named after a timestamp
  ;; and a URL-friendly slug, with title, date, and filetags front matter.
  (org-roam-capture-templates
   '(("d" "default" plain "%?"
      :target (file+head "%<%Y%m%d%H%M%S>-${slug}.org"
                         "#+title: ${title}\n#+date: %<%Y-%m-%d %H:%M>\n#+filetags:\n\n")
      :unnarrowed t)))
  ;; How each node appears in the minibuffer completion list: title, then tags
  (org-roam-node-display-template
   (concat "${title:*} "
           (propertize "${tags:10}" 'face 'org-tag)))
  :config
  ;; Keep the SQLite database in sync with notes files automatically.
  ;; This enables persistent caching of backlinks, tags, and node metadata.
  (org-roam-db-autosync-mode)
  ;; Create the notes directory if it does not exist yet
  (unless (file-directory-p org-roam-directory)
    (make-directory org-roam-directory t))
  ;; setup the org-roam
  (org-roam-setup))

(provide 'org-roam-config)
;;; org-roam-config.el ends here

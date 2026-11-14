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

(use-package ob-mermaid
  :ensure t
  :after org
  :config
  (add-to-list 'org-babel-tangle-lang-exts '("mermaid" . "mmd")))

(use-package ox-gfm
  :ensure t
  :after org)  ;; after org

(use-package org-roam
  :ensure t
  :defer t
  :bind (("C-c n f" . org-roam-node-find) ;; find note
         ("C-c n i" . org-roam-node-insert) ;; insert link
         ("C-c n l" . org-roam-buffer-toggle) ;; backlinks
         ("C-c n g" . org-roam-graph) ;; graph
         ("C-c n t" . org-roam-tag-add) ;; add tag
         ("C-c n a" . org-roam-alias-add)) ;; add alias
  :custom
  ;; Notes dir
  (org-roam-directory (file-truename (expand-file-name "org/notes/" user-emacs-directory)))
  ;; Capture template
  (org-roam-capture-templates
   '(("d" "default" plain "%?"
      :target (file+head "%<%Y%m%d%H%M%S>-${slug}.org"
                         "#+title: ${title}\n#+date: %<%Y-%m-%d %H:%M>\n#+filetags:\n\n")
      :unnarrowed t)))
  ;; Node display: title + tags
  (org-roam-node-display-template
   (concat "${title}"
           (propertize " ${tags}" 'face 'org-tag)))
  :config
  ;; Autosync DB
  (org-roam-db-autosync-mode)
  ;; Graph via fdp
  (setq org-roam-graph-executable "fdp")
  ;; mkdir if missing
  (unless (file-directory-p org-roam-directory)
    (make-directory org-roam-directory t)))

(provide 'org-config)
;;; org-config.el ends here

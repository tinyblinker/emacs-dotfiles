;;; -*- lexical-binding: t -*-

;; Networked notes
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

(provide 'org-roam-config)
;;; org-roam-config.el ends here

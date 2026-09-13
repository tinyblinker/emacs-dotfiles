;;; -*- lexical-binding: t -*-

;; Dirvish: yazi/ranger-style file manager built on dired
;; (simulates neotree sidebar + yazi file browsing)
(use-package dirvish
  :ensure t
  :init
  (dirvish-override-dired-mode 1)  ;; make dired (C-x d) open dirvish instead
  :custom
  (dirvish-attributes '(nerd-icons file-size git-rainbow subtree-state collapse))
  (dirvish-cache-dir (expand-file-name "var/dirvish" user-emacs-directory))
  :bind (("C-c d" . dirvish-side)))  ;; sidebar file tree (neotree replacement)

(provide 'dirvish-config)
;;; dirvish-config.el ends here

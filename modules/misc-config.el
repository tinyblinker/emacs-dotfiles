;;; -*- lexical-binding: t -*-
(use-package dirvish
  :ensure t
  :init
  ;; Load dirvish extensions
  (add-to-list 'load-path
               (expand-file-name "extensions"
                                 (file-name-directory (locate-library "dirvish"))))
  (dirvish-override-dired-mode 1)  ;; open dirvish on C-x d
  :custom
  ;; Icons, size, git, subtree
  (dirvish-attributes '(nerd-icons file-size git-rainbow subtree-state collapse))
  ;; Two-pane layout
  (dirvish-default-layout '(0 0 0.4))
  ;; No header/mode-line windows
  (dirvish-use-header-line nil)
  (dirvish-use-mode-line nil)
  (dirvish-cache-dir (expand-file-name "var/dirvish" user-emacs-directory)))

(use-package dired
  :custom
  (dired-dwim-target t)           ;; dwim target
  (dired-auto-revert-buffer t))   ;; auto-revert

(provide 'misc-config)
;;; misc-config.el ends here

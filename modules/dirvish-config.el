;;; -*- lexical-binding: t -*-

;; Yazi-style file manager
(use-package dirvish
  :ensure t
  :init
  ;; Load dirvish extensions
  (add-to-list 'load-path
               (expand-file-name "extensions"
                                 (file-name-directory (locate-library "dirvish"))))
  (dirvish-override-dired-mode 1)  ;; open dirvish on C-x d
  ;; Autoload dirvish-side
  (autoload 'dirvish-side "dirvish-side" nil t)
  (global-set-key (kbd "C-c d") #'dirvish-side)
  :custom
  ;; Icons, size, git, subtree
  (dirvish-attributes '(nerd-icons file-size git-rainbow subtree-state collapse))
  ;; Two-pane layout
  (dirvish-default-layout '(0 0 0.4))
  ;; No header/mode-line windows
  (dirvish-use-header-line nil)
  (dirvish-use-mode-line nil)
  (dirvish-cache-dir (expand-file-name "var/dirvish" user-emacs-directory)))

(provide 'dirvish-config)
;;; dirvish-config.el ends here

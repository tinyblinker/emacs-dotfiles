;;; -*- lexical-binding: t -*-
(use-package which-key
  :ensure t
  :demand t
  :custom
  (which-key-idle-delay 0.5)
  (which-key-min-display-lines 3)
  (which-key-max-description-length 27)
  ;; Show on C-h
  (which-key-show-early-on-C-h t)
  ;; Popup at bottom
  (which-key-side-window-location 'bottom)
  ;; Key/desc separator
  (which-key-separator " -> ")
  :config
  (which-key-mode 1))

(use-package ibuffer
  :bind ("<remap><list-buffer>" . ibuffer-list-buffers)
  :custom
  (ibuffer-movement-cycle nil)  ;; no wrap
  (ibuffer-old-time 24))        ;; old after 24h

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

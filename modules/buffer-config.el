;;; -*- lexical-binding: t -*-

(setq recentf-save-file (expand-file-name "var/recentf" user-emacs-directory))
(setq savehist-file (expand-file-name "var/history" user-emacs-directory))

(use-package ibuffer
  :bind ("<remap><list-buffer>" . ibuffer-list-buffers)
  :custom
  (ibuffer-movement-cycle nil)
  (ibuffer-old-time 24))

(add-to-list 'display-buffer-alist
             '("\\*Help\\*"
               (display-buffer-reuse-window display-buffer-pop-up-window)))
(add-to-list 'display-buffer-alist
             '("\\*Completions\\*"
               (display-buffer-reuse-window display-buffer-pop-up-window)
               (inhibit-same-window . t)
               (window-height . 10)))

(use-package recentf
  :hook (after-init . recentf-mode))

(use-package savehist
  :config (savehist-mode 1))

(use-package dired
  :custom
  (dried-dwim-target t)
  (dried-auto-revert-buffer t))

;; window management
(use-package winner
  :config
  (winner-mode 1)
  (define-prefix-command 'windows-key-map)
  :bind (("C-c w" . windows-key-map)
         :map windows-key-map
         ("u" . winner-undo)
         ("r" . winner-redo)
         ("n" . windmove-down)
         ("p" . windmove-up)
         ("b" . windmove-left)
         ("f" . windmove-right)))

(provide 'buffer-config)
;;; buffer-config.el ends here

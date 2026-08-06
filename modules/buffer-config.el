;;; -*- lexical-binding: t -*-

;; Replace the default buffer list with ibuffer (filterable, grouped view)
(use-package ibuffer
  :bind ("<remap><list-buffer>" . ibuffer-list-buffers)
  :custom
  (ibuffer-movement-cycle nil)
  (ibuffer-old-time 24))

;; Always reuse or pop up a window for Help and Completions buffers
(add-to-list 'display-buffer-alist
             '("\\*Help\\*"
               (display-buffer-reuse-window display-buffer-pop-up-window)))
(add-to-list 'display-buffer-alist
             '("\\*Completions\\*"
               (display-buffer-reuse-window display-buffer-pop-up-window)
               (inhibit-same-window . t)
               (window-height . 10)))

;; Track recently opened files for quick access
(use-package recentf
  :hook (after-init . recentf-mode)
  :custom
  (recentf-exclude '("var/" "elpa/" ".git/" "^/tmp/" "/ssh:" "/sudo:")))

;; Save and restore minibuffer history across sessions
(use-package savehist
  :custom
  (savehist-additional-variables '(kill-ring register-alist search-ring regexp-search-ring))
  :config (savehist-mode 1))

;; Smarter Dired: guess the copy target and auto-revert
(use-package dired
  :custom
  (dired-dwim-target t)
  (dired-auto-revert-buffer t))

;; Window movement and undo/redo: C-c w {n,p,b,f} move, {u,r} undo/redo layout
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

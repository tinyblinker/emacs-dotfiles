;;; -*- lexical-binding: t -*-

;; Window management: display rules + winner undo/redo + windmove navigation

;; Always reuse or pop up a window for Help and Completions buffers
(add-to-list 'display-buffer-alist
             '("\\*Help\\*"
               (display-buffer-reuse-window display-buffer-pop-up-window)))
(add-to-list 'display-buffer-alist
             '("\\*Completions\\*"
               (display-buffer-reuse-window display-buffer-pop-up-window)
               (inhibit-same-window . t)
               (window-height . 10)))

;; Window layout undo/redo and movement: C-c w {n,p,b,f} move, {u,r} undo/redo
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

(provide 'window-config)
;;; window-config.el ends here

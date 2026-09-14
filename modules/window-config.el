;;; -*- lexical-binding: t -*-

;; Windows
;; Help/Completions windows
(add-to-list 'display-buffer-alist
             '("\\*Help\\*"
               (display-buffer-reuse-window display-buffer-pop-up-window)))
(add-to-list 'display-buffer-alist
             '("\\*Completions\\*"
               (display-buffer-reuse-window display-buffer-pop-up-window)
               (inhibit-same-window . t)
               (window-height . 10)))

;; C-c w layout + move
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

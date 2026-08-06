;;; -*- lexical-binding: t -*-

;; which-key: popup keybinding hints after a prefix key (built-in since Emacs 30)
(use-package which-key
  :defer 0
  :custom
  (which-key-idle-delay 0.5)
  (which-key-min-display-lines 3)
  (which-key-max-description-length 27)
  ;; Show hints immediately when pressing C-h
  (which-key-show-early-on-C-h t)
  ;; Display the popup at the bottom of the frame
  (which-key-side-window-location 'bottom)
  ;; Separator between key and description
  (which-key-separator " → ")
  :config
  (which-key-mode 1))

(provide 'which-key-config)
;;; which-key-config.el ends here

;;; -*- lexical-binding: t -*-

;; Keybinding hints popup
(use-package which-key
  :defer 1
  :custom
  (which-key-idle-delay 0.5)
  (which-key-min-display-lines 3)
  (which-key-max-description-length 27)
  ;; Show on C-h
  (which-key-show-early-on-C-h t)
  ;; Popup at bottom
  (which-key-side-window-location 'bottom)
  ;; Key/desc separator
  (which-key-separator " → ")
  :config
  (which-key-mode 1))

(provide 'which-key-config)
;;; which-key-config.el ends here

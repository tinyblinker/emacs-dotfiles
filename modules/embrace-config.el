;;; -*- lexical-binding: t -*-

;; Embrace: add/change/delete surrounding pairs (simulates surround.nvim)
(use-package embrace
  :ensure t
  :bind (("C-c e a" . embrace-add)     ;; wrap region in a pair
         ("C-c e c" . embrace-change)  ;; change surrounding pair
         ("C-c e d" . embrace-delete))) ;; delete surrounding pair

(provide 'embrace-config)
;;; embrace-config.el ends here

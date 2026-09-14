;;; -*- lexical-binding: t -*-

;; Extra completion backends
(use-package cape
  :ensure t
  :bind ("C-c p" . cape-prefix-map) ;; cape prefix map
  :init
  (add-hook 'completion-at-point-functions #'cape-dabbrev)     ;; dabbrev
  (add-hook 'completion-at-point-functions #'cape-file)        ;; files
  (add-hook 'completion-at-point-functions #'cape-keyword)     ;; keywords
  (add-hook 'completion-at-point-functions #'cape-elisp-block)) ;; elisp

(provide 'cape-config)
;;; cape-config.el ends here

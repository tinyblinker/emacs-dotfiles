;;; -*- lexical-binding: t -*-

;; Cape: extra completion-at-point backends (dabbrev, files, keywords, elisp)
(use-package cape
  :ensure t
  :bind ("C-c p" . cape-prefix-map) ;; Prefix map with all cape commands
  :init
  (add-hook 'completion-at-point-functions #'cape-dabbrev)     ;; Complete from other buffers
  (add-hook 'completion-at-point-functions #'cape-file)        ;; Complete file paths
  (add-hook 'completion-at-point-functions #'cape-keyword)     ;; Complete programming keywords
  (add-hook 'completion-at-point-functions #'cape-elisp-block)) ;; Complete in elisp contexts

(provide 'cape-config)
;;; cape-config.el ends here

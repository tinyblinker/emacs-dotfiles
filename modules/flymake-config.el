;;; -*- lexical-binding: t -*-

;; Diagnostics navigation
(use-package flymake
  :bind (("C-c ! n" . flymake-goto-next-error)
         ("C-c ! p" . flymake-goto-prev-error)))

(provide 'flymake-config)
;;; flymake-config.el ends here

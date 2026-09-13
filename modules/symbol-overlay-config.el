;;; -*- lexical-binding: t -*-

;; Symbol-overlay: highlight all occurrences of the symbol at point
(use-package symbol-overlay
  :ensure t
  :hook (prog-mode . symbol-overlay-mode)
  :bind (:map symbol-overlay-mode-map
              ("M-p" . symbol-overlay-jump-prev)
              ("M-n" . symbol-overlay-jump-next)))

(provide 'symbol-overlay-config)
;;; symbol-overlay-config.el ends here

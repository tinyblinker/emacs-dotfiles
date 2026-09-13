;;; -*- lexical-binding: t -*-

;; Keycast: show pressed keys in the mode line.
;; Uses keycast's defaults: the widget is inserted after the buffer name,
;; and `keycast-mode-line-remove-tail-elements' stays t, so the
;; line/column indicator is removed (the original appearance).
(use-package keycast
  :ensure t
  :defer 1               ; load 1s after idle, mode-line can wait
  :config
  (keycast-mode-line-mode 1))

(provide 'keycast-config)
;;; keycast-config.el ends here

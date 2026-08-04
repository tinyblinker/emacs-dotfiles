;;; -*- lexical-binding: t -*-

;; set "keycast" for the real-time display of the kdb
(when (locate-library "keycast")
  (customize-set-variable 'keycast-mode-line-remove-tail-elements nil)
  (customize-set-variable 'keycast-mode-line-insert-after 'mode-line-misc-info)
  (keycast-mode-line-mode))

;; add necessaey features
(provide 'crafted-screencast-config)
;;; crafted-screencast.el ends here

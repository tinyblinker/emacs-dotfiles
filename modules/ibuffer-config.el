;;; -*- lexical-binding: t -*-

;; Filterable buffer list
(use-package ibuffer
  :bind ("<remap><list-buffer>" . ibuffer-list-buffers)
  :custom
  (ibuffer-movement-cycle nil)  ;; no wrap
  (ibuffer-old-time 24))        ;; old after 24h

(provide 'ibuffer-config)
;;; ibuffer-config.el ends here

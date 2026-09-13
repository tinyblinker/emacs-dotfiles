;;; -*- lexical-binding: t -*-

;; IBuffer: advanced, filterable buffer list (replaces default list-buffers)
(use-package ibuffer
  :bind ("<remap><list-buffer>" . ibuffer-list-buffers)
  :custom
  (ibuffer-movement-cycle nil)  ;; Do not wrap around buffer list ends
  (ibuffer-old-time 24))        ;; Mark buffers as "old" after 24 hours

(provide 'ibuffer-config)
;;; ibuffer-config.el ends here

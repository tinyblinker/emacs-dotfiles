;;; -*- lexical-binding: t -*-

;; In-buffer popup completion
(use-package corfu
  :ensure t
  :defer 1
  :custom
  (corfu-cycle t)                ;; wrap around
  (corfu-auto t)                 ;; auto popup
  (corfu-auto-prefix 2)          ;; after 2 chars
  (corfu-auto-delay 0.2)         ;; 0.2s delay
  (corfu-preselect 'prompt)      ;; preselect first
  (corfu-quit-no-match 'separator) ;; quit on no match
  (corfu-on-exact-match 'insert) ;; insert on exact
  :config
  (global-corfu-mode 1)
  (corfu-history-mode 1)    ;; history
  (corfu-popupinfo-mode 1)  ;; doc popup
  (corfu-echo-mode 1)       ;; echo info
  (corfu-indexed-mode 1))   ;; index numbers

(provide 'corfu-config)
;;; corfu-config.el ends here

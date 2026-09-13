;;; -*- lexical-binding: t -*-

;; Corfu: in-buffer popup completion with auto-trigger
(use-package corfu
  :ensure t
  :defer 1
  :custom
  (corfu-cycle t)                ;; Wrap around at list boundaries
  (corfu-auto t)                 ;; Show popup automatically while typing
  (corfu-auto-prefix 2)          ;; Trigger after at least 2 characters typed
  (corfu-auto-delay 0.2)         ;; Wait 0.2s before showing popup
  (corfu-preselect 'prompt)      ;; Pre-select the first candidate
  (corfu-quit-no-match 'separator) ;; Quit if typed text doesn't match
  (corfu-on-exact-match 'insert) ;; Auto-insert when only one exact match remains
  :config
  (global-corfu-mode 1)
  (corfu-history-mode 1)    ;; Save selected candidates for future sorting
  (corfu-popupinfo-mode 1)  ;; Show documentation popup for selected candidate
  (corfu-echo-mode 1)       ;; Echo candidate info in the echo area
  (corfu-indexed-mode 1))   ;; Show index numbers for quick selection

(provide 'corfu-config)
;;; corfu-config.el ends here

;;; -*- lexical-binding: t; -*-

;; Completion defaults: flex matching, vertical display
(setq tab-always-indent 'complete   ;; Tab = indent if at indentation, else trigger completion
      completions-format 'vertical   ;; Display completions in a vertical list
      xref-show-definitions-function #'xref-show-definitions-completing-read ;; Fuzzy choose definitions
      completion-styles '(flex basic) ;; Use flex (fuzzy) matching first, fall back to basic
      completion-category-overrides '((file (styles . (partial-completion))))) ;; Use partial-completion for file paths

;; Vertical minibuffer completion using built-in fido-vertical
(fido-vertical-mode 1)

;; Bind TAB to icomplete's inline force-complete (avoids popping up *Completions* buffer)
(with-eval-after-load 'icomplete
  (keymap-set icomplete-minibuffer-map "TAB" #'icomplete-force-complete)
  (keymap-set icomplete-minibuffer-map "<tab>" #'icomplete-force-complete))

;; Corfu: in-buffer popup completion with auto-trigger
(use-package corfu
  :ensure t
  :custom
  (corfu-cycle t)                ;; Wrap around at list boundaries
  (corfu-auto t)                 ;; Show popup automatically while typing
  (corfu-auto-prefix 2)          ;; Trigger after at least 2 characters typed
  (corfu-auto-delay 0.2)         ;; Wait 0.2s before showing popup
  (corfu-preselect 'prompt)      ;; Pre-select the prompt (first candidate by default)
  (corfu-quit-no-match 'separator) ;; Quit if typed text doesn't match anything
  (corfu-on-exact-match 'insert) ;; Auto-insert when only one exact match remains
  :config
  (global-corfu-mode 1)
  (corfu-history-mode 1)    ;; Save selected candidates for future sorting
  (corfu-popupinfo-mode 1)  ;; Show documentation popup for selected candidate
  (corfu-echo-mode 1)       ;; Echo candidate info in the echo area
  (corfu-indexed-mode 1))   ;; Show index numbers for quick keyboard selection

;; Cape: extra completion-at-point backends for dabbrev, file names, keywords, elisp
(use-package cape
  :ensure t
  :bind ("C-c p" . cape-prefix-map) ;; Prefix map with all cape commands
  :init
  (add-hook 'completion-at-point-functions #'cape-dabbrev)     ;; Complete from other buffers
  (add-hook 'completion-at-point-functions #'cape-file)        ;; Complete file paths
  (add-hook 'completion-at-point-functions #'cape-keyword)     ;; Complete programming keywords
  (add-hook 'completion-at-point-functions #'cape-elisp-block)) ;; Complete in elisp contexts

(provide 'completion-config)
;;; completion-config.el ends here

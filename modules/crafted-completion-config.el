;;; -*- lexical-binding: t; -*-

;; config "vertico": minibuffer vertical layout
(when (require 'vertico nil :noerror)
  (require 'vertico-directory)
  (customize-set-variable 'vertico-cycle t)

  (vertico-mode 1)

  (with-eval-after-load 'crafted-defaults-config
    (fido-mode -1)
    (fido-vertical-mode -1)
    (icomplete-mode -1)
    (icomplete-vertical-mode -1)))

;; config "marginalia": show docs(more info) in "vertico" completions list
(when (require 'marginalia nil :noerror)
  (marginalia-mode 1))

;; config "consult": (with magic command and RT preview)enhanced search and navigation
(when (locate-library "consult")
  (keymap-global-set "C-s" 'consult-line)
  (keymap-set minibuffer-local-map "C-r" 'consult-history)

  (setq completion-in-region-function #'consult-completion-in-region))

;; config "orderless": with fuzzel alogism supporrt
(when (require 'orderless nil :noerror)
  (customize-set-variable 'completion-styles '(orderless basic))
  (customize-set-variable 'completion-category-overrides
                          '((file (styles . (partial-completion))))))

;; config "embark": show more thing in candidates
;; config "embark-consult": use consult when embark activated
;; (when (require 'embark nil :noerror)

;;   (keymap-global-set "<remap> <describe-bindings>" #'embark-bindings)
;;   (keymap-global-set "C-." 'embark-act)

;;   (setq prefix-help-command #'embark-prefix-help-command)

;;   (when (require 'embark-consult nil :noerror)
;;     (with-eval-after-load 'embark-consult
;;       (add-hook 'embark-collect-mode-hook #'consult-preview-at-point-mode))))

(when (require 'embark-consult nil :noerror)
  (with-eval-after-load 'embark-consult
    (add-hook 'embark-collect-mode-hook #'consult-preview-at-point-mode))
  (when (require 'embark nil :noerror)

    (keymap-global-set "<remap> <describe-bindings>" #'embark-bindings)
    (keymap-global-set "C-." 'embark-act)

    (setq prefix-help-command #'embark-prefix-help-command)))

;; config "corfu": completion ui in buffers
(when (require 'corfu nil :noerror)
  
  (global-completion-preview-mode nil)
  
  (unless (display-graphic-p)
    (when (require 'corfu-terminal nil :noerror)
      (corfu-terminal-mode +1)))

  (customize-set-variable 'corfu-cycle t)
  (customize-set-variable 'corfu-auto t)
  (customize-set-variable 'corfu-auto-prefix 2)

  (global-corfu-mode 1)
  (when (require 'corfu-popupinfo nil :noerror)

    (corfu-popupinfo-mode 1)
    (eldoc-add-command #'corfu-insert)
    (keymap-set corfu-map "M-p" #'corfu-popupinfo-scroll-down)
    (keymap-set corfu-map "M-n" #'corfu-popupinfo-scroll-up)
    (keymap-set corfu-map "M-d" #'corfu-popupinfo-toggle)))

;; config "cape": like friendly snniper in neovim
(when (require 'cape nil :noerror)

  (add-to-list 'completion-at-point-functions #'cape-file)
  (add-to-list 'completion-at-point-functions #'cape-dabbrev)

  (advice-add 'pcomplete-completions-at-point :around #'cape-wrap-silent)

  (defun crafted-completion-corfu-eshell ()
    "Special settings for when using corfu with eshell."
    (setq-local corfu-quit-at-boundary t
                corfu-quit-no-match t
                corfu-auto nil)
    (corfu-mode))
  (add-hook 'eshell-mode-hook #'crafted-completion-corfu-eshell))

;; provide the necessary feature
(provide 'crafted-completion-config)
;;; crafted-completion.el ends here

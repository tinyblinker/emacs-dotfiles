;;; crafted-completion-config.el --- Crafted Completion Configuration -*- lexical-binding: t; -*-

;;; Vertico: VERTical Interactive COmpletion
(when (require 'vertico nil :noerror)
  (require 'vertico-directory)
  ;; Cycle back to top/bottom result when the edge is reached
  (customize-set-variable 'vertico-cycle t)

  ;; Start Vertico
  (vertico-mode 1)

  ;; Turn off the built-in fido-vertical-mode and 
  ;; icomplete-vertical-mode for not interfering with this module.
  (with-eval-after-load 'crafted-defaults-config
    (fido-mode -1)
    (fido-vertical-mode -1)
    (icomplete-mode -1)
    (icomplete-vertical-mode -1)))

;;; Marginalia: Marginalia in the minibuffer
(when (require 'marginalia nil :noerror)
  (marginalia-mode 1))

;;; Consult: Search and navigate via completing-read
;; Since Consult doesn't need to be required, we assume the user wants these
;; setting if it is installed (regardless of the installation method).
(when (locate-library "consult")
  ;; Set some consult bindings
  (keymap-global-set "C-s" 'consult-line)
  (keymap-set minibuffer-local-map "C-r" 'consult-history)

  (setq completion-in-region-function #'consult-completion-in-region))

;;; Orderless: Emacs completion style that matches multiple regexps in any order
(when (require 'orderless nil :noerror)
  ;; Set up Orderless for better fuzzy matching
  (customize-set-variable 'completion-styles '(orderless basic))
  (customize-set-variable 'completion-category-overrides
                          '((file (styles . (partial-completion))))))

;;; Embark: Emacs Mini-Buffer Actions Rooted in Keymaps
(when (require 'embark nil :noerror)

  (keymap-global-set "<remap> <describe-bindings>" #'embark-bindings)
  (keymap-global-set "C-." 'embark-act)

  ;; Use Embark to show bindings in a key prefix with `C-h`
  (setq prefix-help-command #'embark-prefix-help-command)

  (when (require 'embark-consult nil :noerror)
    (with-eval-after-load 'embark-consult
      (add-hook 'embark-collect-mode-hook #'consult-preview-at-point-mode))))

;;; Corfu: COmpletion in Region FUnction
(when (require 'corfu nil :noerror)

  (unless (display-graphic-p)
    (when (require 'corfu-terminal nil :noerror)
      (corfu-terminal-mode +1)))

  ;; Setup corfu for popup like completion
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

;;; Cape: Completion At Point Extensions

(when (require 'cape nil :noerror)
  ;; Setup Cape for better completion-at-point support and more

  ;; Add useful defaults completion sources from cape
  (add-to-list 'completion-at-point-functions #'cape-file)
  (add-to-list 'completion-at-point-functions #'cape-dabbrev)

  ;; Silence the pcomplete capf, no errors or messages!
  ;; Important for corfu
  (advice-add 'pcomplete-completions-at-point :around #'cape-wrap-silent)

  ;; No auto-completion or completion-on-quit in eshell
  (defun crafted-completion-corfu-eshell ()
    "Special settings for when using corfu with eshell."
    (setq-local corfu-quit-at-boundary t
                corfu-quit-no-match t
                corfu-auto nil)
    (corfu-mode))
  (add-hook 'eshell-mode-hook #'crafted-completion-corfu-eshell))

(provide 'crafted-completion-config)
;;; crafted-completion.el ends here

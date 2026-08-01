;;; -*- lexical-binding: t; -*-

(defgroup crafted-defaults '()
  "Customizations for Crafted Emacs - Defaults."
  :tag "Crafted Defaults"
  :group 'crafted)

(defcustom crafted-windows-prefix-key "C-c w"
  "Configure the prefix key for window movement bindings.

Movement commands provided by `windmove' package, `winner-mode'
also enables undo functionality if the window layout changes."
  :group 'crafted-defaults
  :type 'string)


(customize-set-variable 'global-auto-revert-non-file-buffers t)

(global-auto-revert-mode 1)

(customize-set-variable 'dired-dwim-target t)

(customize-set-variable 'dired-auto-revert-buffer t)

(customize-set-variable 'eshell-scroll-to-bottom-on-input 'this)

(customize-set-variable 'switch-to-buffer-in-dedicated-window 'pop)
(customize-set-variable 'switch-to-buffer-obey-display-actions t)

(keymap-global-set "<remap> <list-buffers>" #'ibuffer-list-buffers)
(customize-set-variable 'ibuffer-movement-cycle nil)
(customize-set-variable 'ibuffer-old-time 24)


(if (version< emacs-version "28")
    (if (locate-library "icomplete-vertical")
        (icomplete-vertical-mode 1)
      (icomplete-mode 1))
  (fido-vertical-mode 1))

(when (version< "30" emacs-version)
  (global-completion-preview-mode 1)
  (keymap-set completion-preview-active-mode-map "M-n" #'completion-preview-next-candidate)
  (keymap-set completion-preview-active-mode-map "M-p" #'completion-preview-prev-candidate))

(customize-set-variable 'tab-always-indent 'complete)
(customize-set-variable 'completion-cycle-threshold 3)
(customize-set-variable 'completion-category-overrides
                        '((file (styles . (partial-completion)))))
(customize-set-variable 'completions-detailed t)

(customize-set-variable 'xref-show-definitions-function
                        #'xref-show-definitions-completing-read)


(delete-selection-mode)

(setq-default indent-tabs-mode nil)

(customize-set-variable 'kill-do-not-save-duplicates t)

(setq-default bidi-paragraph-direction 'left-to-right)
(setq-default bidi-inhibit-bpa t)
(global-so-long-mode 1)

(keymap-set global-map "M-#" #'dictionary-lookup-definition)

(add-to-list 'display-buffer-alist
             '("^\\*Dictionary\\*"
               (display-buffer-in-side-window)
               (side . left)
               (window-width . 70)))

(with-eval-after-load 'ispell
  (when (executable-find ispell-program-name)
    (add-hook 'text-mode-hook #'flyspell-mode)
    (add-hook 'prog-mode-hook #'flyspell-prog-mode)))


(when (and (require 'hydra nil :noerror)
           (require 'dumb-jump nil :noerror))
  (defhydra dumb-jump-hydra (:color blue :columns 3)
    "Dumb Jump"
    ("j" dumb-jump-go "Go")
    ("o" dumb-jump-go-other-window "Other window")
    ("e" dumb-jump-go-prefer-external "Go external")
    ("x" dumb-jump-go-prefer-external-other-window "Go external other window")
    ("i" dumb-jump-go-prompt "Prompt")
    ("l" dumb-jump-quick-look "Quick look")
    ("b" dumb-jump-back "Back"))
  (keymap-set dumb-jump-mode-map "C-M-y" #'dumb-jump-hydra/body))

(with-eval-after-load 'dumb-jump
  (add-hook 'xref-backend-functions #'dumb-jump-xref-activate))


(add-hook 'after-init-hook #'recentf-mode)

(savehist-mode 1)

(customize-set-variable 'bookmark-save-flag 1)


(winner-mode 1)

(define-prefix-command 'crafted-windows-key-map)

(keymap-set 'crafted-windows-key-map "u" 'winner-undo)
(keymap-set 'crafted-windows-key-map "r" 'winner-redo)
(keymap-set 'crafted-windows-key-map "n" 'windmove-down)
(keymap-set 'crafted-windows-key-map "p" 'windmove-up)
(keymap-set 'crafted-windows-key-map "b" 'windmove-left)
(keymap-set 'crafted-windows-key-map "f" 'windmove-right)

(keymap-global-set crafted-windows-prefix-key 'crafted-windows-key-map)

(setq auto-window-vscroll nil)
(customize-set-variable 'fast-but-imprecise-scrolling t)
(customize-set-variable 'scroll-conservatively 101)
(customize-set-variable 'scroll-margin 0)
(customize-set-variable 'scroll-preserve-screen-position t)

(customize-set-variable 'Man-notify-method 'aggressive)

(customize-set-variable 'ediff-window-setup-function
                        'ediff-setup-windows-plain)

(add-to-list 'display-buffer-alist
             '("\\*Help\\*"
               (display-buffer-reuse-window display-buffer-pop-up-window)))

(add-to-list 'display-buffer-alist
             '("\\*Completions\\*"
               (display-buffer-reuse-window display-buffer-pop-up-window)
               (inhibit-same-window . t)
               (window-height . 10)))


(customize-set-variable 'load-prefer-newer t)

(add-hook 'after-save-hook
          #'executable-make-buffer-file-executable-if-script-p)

(unless (version< emacs-version "28")
  (repeat-mode 1))


(provide 'crafted-defaults-config)
;;; crafted-defaults-config.el ends here

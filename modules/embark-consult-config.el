;;; -*- lexical-binding: t -*-

;;; Embark: context-sensitive actions on any target at point or in the minibuffer
;;; Press C-. on a file, symbol, URL, buffer name, etc. to see available commands.
;;; Press C-; to run the default action directly (e.g., find-file on a file path).
(use-package embark
  :ensure t
  :bind
  (("C-." . embark-act)            ;; Show actions for the target at point or in minibuffer
   ("C-;" . embark-dwim)           ;; Run the default action immediately, no prompt
   ("C-h B" . embark-bindings))    ;; Describe all current keybindings for the active modes
  :init
  ;; Replace default prefix-key help (C-h after a prefix) with Embark's richer version
  (setq prefix-help-command #'embark-prefix-help-command)
  :config
  ;; Hide the mode-line in Embark collect/completions buffers for a cleaner look
  (add-to-list 'display-buffer-alist
               '("\\`\\*Embark Collect \\(Live\\|Completions\\)\\*"
                 nil
                 (window-parameters (mode-line-format . none)))))

;;; Consult: enhanced minibuffer commands with live candidate preview
;;; Replaces and extends built-ins like goto-line, apropos, bookmark-jump.
;;; Most commands show a live preview of the selected candidate in the buffer.
(use-package consult
  :ensure t
  :bind
  ;; Global search and help commands (C-c prefix)
  ("C-c h" . consult-history)        ;; Search through minibuffer history interactively
  ("C-c m" . consult-man)            ;; Search man pages with preview
  ("C-c i" . consult-info)           ;; Search Info manuals with preview
  ;; Navigation commands (M-g = "go to" prefix)
  ("M-g g" . consult-goto-line)      ;; Go to line with live preview in the buffer
  ("M-g o" . consult-outline)        ;; Go to outline heading (works in org-mode, markdown, etc.)
  ("M-g i" . consult-imenu)          ;; Go to symbol/heading in current buffer (like imenu but with preview)
  ("M-g m" . consult-mark)           ;; Jump to a local mark with live preview
  ;; Search commands (M-s = search prefix)
  ("M-s g" . consult-grep)           ;; Grep through files with live match preview
  ("M-s r" . consult-ripgrep)        ;; Ripgrep through files (faster, respects .gitignore)
  ("M-s l" . consult-line)           ;; Search lines in the current buffer with live preview
  ("M-s d" . consult-find)           ;; Find files by name recursively using system `find'
  ("M-s f" . consult-fd)             ;; Find files by name using `fd' (faster, respects .gitignore)
  ;; Yank and register commands
  ("M-y" . consult-yank-pop)         ;; Enhanced yank-pop with live preview of each kill-ring entry
  ;; Minibuffer-local history search
  :map isearch-mode-map
  ("M-e" . consult-isearch-history)  ;; Search through isearch history while isearch is active
  :map minibuffer-local-map
  ("M-s" . consult-history)          ;; Search history while in the minibuffer
  ("M-r" . consult-history)
  :init
  ;; Use Consult's richer register preview instead of the default one-line display
  (advice-add #'register-preview :override #'consult-register-window)
  (setq register-preview-delay 0.5)
  ;; Route xref (go-to-definition / find-references) through Consult for live preview
  (setq xref-show-xrefs-function #'consult-xref
        xref-show-definitions-function #'consult-xref)
  :config
  ;; Set narrowing key: press C-+ inside a consult command to narrow by category
  (setq consult-narrow-key "C-+")
  ;; Show absolute line numbers even when the buffer is narrowed
  (setq consult-line-numbers-widen t)
  ;; Fine-tune preview behavior per command: debounce prevents flicker on fast typing
  (consult-customize
   consult-theme :preview-key '(:debounce 0.2 any)
   consult-ripgrep consult-grep consult-man
   :preview-key '(:debounce 0.4 any)))

;;; Embark-Consult: bridge package that connects Consult commands with Embark actions
;;; After installing, Embark automatically understands Consult-specific targets
;;; (e.g., consult-buffer entries, grep match lines) and offers appropriate actions.
(use-package embark-consult
  :ensure t
  :after (embark consult))           ;; Load after both embark and consult are ready

(provide 'embark-consult-config)
;;; embark-consult-config.el ends here

;;; -*- lexical-binding: t -*-
(use-package which-key
  :ensure t
  :demand t
  :custom
  (which-key-idle-delay 0.5)
  (which-key-min-display-lines 3)
  (which-key-max-description-length 27)
  ;; Show on C-h
  (which-key-show-early-on-C-h t)
  ;; Popup at bottom
  (which-key-side-window-location 'bottom)
  ;; Key/desc separator
  (which-key-separator " -> ")
  :config
  (which-key-mode 1))

(use-package ibuffer
  :bind ("<remap><list-buffer>" . ibuffer-list-buffers)
  :custom
  (ibuffer-movement-cycle nil)  ;; no wrap
  (ibuffer-old-time 24))        ;; old after 24h

(use-package ghostel
  :ensure t
  :hook (after-init . ghostel-status-indicator-mode)
  :bind (("C-x m" . ghostel)
         :map ghostel-semi-char-mode-map
         ("C-s"  . consult-line)
         ("C-k"  . my/ghostel-send-C-k-and-kill)
         ;; I'm used to go up/down the shell history with M-n/p from eshell
         ;; Simulate this behavior in ghostel by sending C-p and C-n
         ("M-p" . (lambda () (interactive) (ghostel-send-key "p" "ctrl")))
         ("M-n" . (lambda () (interactive) (ghostel-send-key "n" "ctrl"))))
  :config
  (defun my/ghostel-send-C-k-and-kill ()
    "Send `C-k' to ghostel.
Like normal Emacs `C-k'.  Kill to end of line and put content in kill-ring."
    (interactive)
    (kill-ring-save (point) (line-end-position))
    (ghostel-send-key "k" "ctrl"))

  (add-to-list 'ghostel-eval-cmds '("magit-status-setup-buffer" magit-status-setup-buffer)))

(use-package ghostel-project
  :bind (:map project-prefix-map
         ("m" . ghostel-project)
         ("M" . ghostel-project-list-buffers))
  :config
  (add-to-list 'project-switch-commands '(ghostel-project "Ghostel") t)
  (add-to-list 'project-switch-commands '(ghostel-project-list-buffers "Ghostel buffers") t))

(use-package exec-path-from-shell
  :ensure t
  :if (and (or (display-graphic-p) (daemonp))
           (not (member system-type '(ms-dos windows-nt cygwin haiku android))))
  :config
  (dolist (var '("SSH_AUTH_SOCK" "SSH_AGENT_PID" "GPG_AGENT_INFO" "LANG"
                 "LC_CTYPE" "GOPATH" "PYTHONPATH" "JAVA_HOME"))
    (add-to-list 'exec-path-from-shell-variables var))
  (exec-path-from-shell-initialize))


(use-package dirvish
  :ensure t
  :init
  ;; Load dirvish extensions
  (add-to-list 'load-path
               (expand-file-name "extensions"
                                 (file-name-directory (locate-library "dirvish"))))
  (dirvish-override-dired-mode 1)  ;; open dirvish on C-x d
  :custom
  ;; Icons, size, git, subtree
  (dirvish-attributes '(nerd-icons file-size git-rainbow subtree-state collapse))
  ;; Two-pane layout
  (dirvish-default-layout '(0 0 0.4))
  ;; No header/mode-line windows
  (dirvish-use-header-line nil)
  (dirvish-use-mode-line nil)
  (dirvish-cache-dir (expand-file-name "var/dirvish" user-emacs-directory)))

(use-package dired
  :custom
  (dired-dwim-target t)           ;; dwim target
  (dired-auto-revert-buffer t))   ;; auto-revert

(provide 'core-config)
;;; core-config.el ends here

;;; -*- lexical-binding: t -*-

;; Dirvish: yazi/ranger-style file manager built on dired
;; (simulates neotree sidebar + yazi file browsing)
(use-package dirvish
  :ensure t
  :init
  ;; Dirvish ships its optional extensions (dirvish-icons, dirvish-subtree,
  ;; dirvish-collapse, dirvish-side, ...) in elpa/dirvish-<ver>/extensions/,
  ;; which is NOT on the load-path by default.  Without it
  ;; `dirvish--check-dependencies' fails to `require' them (e.g. "Cannot open
  ;; load file dirvish-icons").  Add it before dirvish is loaded.
  (add-to-list 'load-path
               (expand-file-name "extensions"
                                 (file-name-directory (locate-library "dirvish"))))
  (dirvish-override-dired-mode 1)  ;; make dired (C-x d) open dirvish instead
  ;; dirvish-side is defined in the extensions dir, so use-package's :bind
  ;; would autoload it from "dirvish" (the wrong file) and fail.  Autoload it
  ;; explicitly and bind the key ourselves.
  (autoload 'dirvish-side "dirvish-side" nil t)
  (global-set-key (kbd "C-c d") #'dirvish-side)
  :custom
  ;; Icons, file size, git state, subtree/collapse indicators.
  (dirvish-attributes '(nerd-icons file-size git-rainbow subtree-state collapse))
  ;; A clean two-pane layout: current dir | preview.  The default
  ;; '(1 0.11 0.55) adds parent-directory panes that clutter the frame.
  (dirvish-default-layout '(0 0 0.4))
  (dirvish-cache-dir (expand-file-name "var/dirvish" user-emacs-directory)))

(provide 'dirvish-config)
;;; dirvish-config.el ends here

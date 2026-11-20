;;; -*- lexical-binding: t -*-

;; load config
(load (expand-file-name "early-init.el" user-emacs-directory) nil t)
(package-initialize)
(load (expand-file-name "init.el" user-emacs-directory) nil t)

;; check version
(unless (string-prefix-p "31.1" emacs-version)
  (error "ci: expected Emacs 31.1, got %s" emacs-version))

;; check modules
(dolist (module loaded-modules-list)
  (unless (featurep module)
    (error "ci: module missing: %s" module)))

;; check bash
(require 'sh-script)
(require 'eglot)
(unless (memq 'eglot-ensure bash-ts-mode-hook)
  (error "ci: bash eglot hook missing"))
(unless (eq (keymap-lookup bash-ts-mode-map "C-c C-f")
            #'eglot-format-buffer)
  (error "ci: bash format key missing"))
(let ((contact (cdr (eglot--lookup-mode 'bash-ts-mode))))
  (unless (equal (car contact) "bash-language-server")
    (error "ci: bash server wrong: %S" contact)))
(let ((ide (plist-get (default-value 'eglot-workspace-configuration) :bashIde)))
  (unless (equal (plist-get ide :shellcheckPath) "shellcheck")
    (error "ci: shellcheck path wrong"))
  (unless (equal (plist-get (plist-get ide :shfmt) :path) "shfmt")
    (error "ci: shfmt path wrong")))

;; check c
(require 'c-ts-mode)
(unless (memq 'eglot-ensure c-ts-mode-hook)
  (error "ci: c eglot hook missing"))
(unless (eq (keymap-lookup c-ts-mode-map "C-c C-f")
            #'eglot-format-buffer)
  (error "ci: c format key missing"))
(let ((contact (cdr (eglot--lookup-mode 'c-ts-mode))))
  (unless (equal (car contact) "clangd")
    (error "ci: c server wrong: %S" contact))
  (unless (member "--clang-tidy" contact)
    (error "ci: clang-tidy flag missing"))
  (unless (member "--enable-config" contact)
    (error "ci: clangd config flag missing")))

;; check rust
(require 'rust-ts-mode)
(unless (memq 'eglot-ensure rust-ts-mode-hook)
  (error "ci: rust eglot hook missing"))
(unless (eq (keymap-lookup rust-ts-mode-map "C-c C-f")
            #'eglot-format-buffer)
  (error "ci: rust format key missing"))
(let* ((contact (cdr (eglot--lookup-mode 'rust-ts-mode)))
       (options (plist-get (cdr contact) :initializationOptions)))
  (unless (equal (car contact) "rust-analyzer")
    (error "ci: rust server wrong: %S" contact))
  (unless (equal (plist-get (plist-get options :check) :command) "clippy")
    (error "ci: rust clippy missing")))

;; check warnings
(when (get-buffer "*Warnings*")
  (with-current-buffer "*Warnings*"
    (goto-char (point-min))
    (when (re-search-forward "Cannot load\\|Failed to install" nil t)
      (error "ci: package warning: %s"
             (buffer-substring-no-properties (line-beginning-position)
                                             (line-end-position))))))

;; check success
(message "ci: ok")

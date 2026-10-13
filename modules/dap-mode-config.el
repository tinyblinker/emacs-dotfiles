;;; -*- lexical-binding: t -*-

;; Hydra package for dap-hydra
(use-package hydra
  :ensure t
  :defer t)

;; Cargo binary lookup for the debug template
(defun dap-mode-config--cargo-name (manifest)
  "Return the [package] name in MANIFEST."
  (with-temp-buffer
    (insert-file-contents manifest)
    (goto-char (point-min))
    (when (and (re-search-forward "^\\[package\\]" nil t)
               (re-search-forward "^name[ \t]*=[ \t]*\"\\([^\"]+\\)\"" nil t))
      (match-string-no-properties 1))))

(defun dap-mode-config--cargo-root (dir)
  "Return the topmost Cargo.toml directory at or above DIR."
  (let ((up (directory-file-name (file-name-directory (file-name-as-directory dir)))))
    (if (and (not (equal up dir))
             (file-exists-p (expand-file-name "Cargo.toml" up)))
        (dap-mode-config--cargo-root up)
      dir)))

(defun dap-mode-config--cargo-bins (pkg)
  "Return the binary target names of the package in PKG."
  (let ((main (and (file-exists-p (expand-file-name "src/main.rs" pkg))
                   (or (dap-mode-config--cargo-name (expand-file-name "Cargo.toml" pkg))
                       (file-name-nondirectory (directory-file-name pkg)))))
        (bins (file-expand-wildcards (expand-file-name "src/bin/*.rs" pkg))))
    (append (when main (list main)) (mapcar #'file-name-base bins))))

(defun dap-mode-config--cargo-bin ()
  "Return the cargo binary file to debug for the current buffer."
  (let* ((file (buffer-file-name))
         (manifest (locate-dominating-file (or file default-directory) "Cargo.toml"))
         (pkg (file-name-directory manifest))
         (root (dap-mode-config--cargo-root (directory-file-name pkg)))
         (rel (and file (file-relative-name file pkg))))
    (cond
     ((and rel (string-match "\\`examples/\\([^/]+\\)\\.rs\\'" rel))
      (expand-file-name (format "target/debug/examples/%s" (match-string 1 rel)) root))
     ((and rel (string-match "\\`src/bin/\\([^/]+\\)\\.rs\\'" rel))
      (expand-file-name (format "target/debug/%s" (match-string 1 rel)) root))
     ((dap-mode-config--cargo-bins pkg)
      (expand-file-name (concat "target/debug/" (car (dap-mode-config--cargo-bins pkg))) root))
     (t (user-error "%s has no binary target; add src/main.rs or an example" pkg)))))

(defun dap-mode-config--add-rust-bin ()
  "Register ${rustBin} for dap templates."
  (add-to-list 'dap-variables-current-variables
               (cons "\\`rustBin\\'" #'dap-mode-config--cargo-bin)))

;; Recreate markers for breakpoints loaded from disk
(defun dap-mode-config--restore-breakpoints ()
  "Recreate markers for restored breakpoints in the current file."
  (when-let* ((file buffer-file-name)
              (breakpoints (gethash file (dap--get-breakpoints))))
    (dap--set-breakpoints-in-file file breakpoints)))

;; DAP client (global)
(use-package dap-mode
  :ensure t
  :demand t   ;; load at startup
  :custom
  (dap-auto-configure-features '(sessions locals breakpoints expressions))
  (dap-gdb-debug-program '("rust-gdb" "-i" "dap")) ;; rust-gdb adds Rust pretty printers
  :bind (:map dap-mode-map
              ("C-c C-d d" . dap-debug)
              ("C-c C-d l" . dap-debug-last)
              ("C-c C-d r" . dap-debug-restart)
              ("C-c C-d q" . dap-disconnect)
              ("C-c C-d b" . dap-breakpoint-toggle)
              ("C-c C-d C" . dap-breakpoint-condition)
              ("C-c C-d c" . dap-continue)
              ("C-c C-d n" . dap-next)
              ("C-c C-d i" . dap-step-in)
              ("C-c C-d o" . dap-step-out)
              ("C-c C-d R" . dap-restart-frame)
              ("C-c C-d e" . dap-eval-thing-at-point)
              ("C-c C-d E" . dap-eval)
              ("C-c C-d s" . dap-ui-sessions)
              ("C-c C-d v" . dap-ui-locals)
              ("C-c C-d B" . dap-ui-breakpoints-list)
              ("C-c C-d h" . dap-hydra))
  :config
  (require 'dap-gdb)
  ;; dap-mode asks lsp-mode for the project root; fall back to project.el
  (advice-add 'lsp-workspace-root :around
              (lambda (orig &rest args)
                (or (apply orig args)
                    (when-let* ((project (project-current nil default-directory)))
                      (directory-file-name (project-root project))))))
  (dap-auto-configure-mode 1)
  ;; Upstream bug: breakpoints restored from disk have no marker
  (advice-add 'dap--buffers-w-breakpoints :override
              (lambda ()
                (delq nil (mapcar (lambda (bps)
                                    (when-let* ((marker (plist-get (car bps) :marker)))
                                      (marker-buffer marker)))
                                  (hash-table-values (dap--get-breakpoints))))))
  ;; Add ${rustBin} to dap variables
  (add-hook 'dap-variables-post-walk-hook #'dap-mode-config--add-rust-bin)
  ;; Restore markers for saved breakpoints in opened files
  (add-hook 'find-file-hook #'dap-mode-config--restore-breakpoints)
  ;; Build with cargo, then debug the package binary
  (dap-register-debug-template
   "Rust :: gdb"
   (list :type "gdb"
         :request "launch"
         :name "Rust :: gdb"
         :program "${rustBin}"
         :cwd "${workspaceFolder}"
         :dap-compilation "cargo build"
         :dap-compilation-dir "${workspaceFolder}"))
  (require 'dap-hydra)
  ;; Pop the hydra when the program stops
  (add-hook 'dap-stopped-hook (lambda (_arg) (call-interactively #'dap-hydra))))

(provide 'dap-mode-config)
;;; dap-mode-config.el ends here

;;; -*- lexical-binding: t -*-

;; Hydra package for dap-hydra
(use-package hydra
  :ensure t
  :defer t)

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
                    (when-let ((project (project-current nil default-directory)))
                      (directory-file-name (project-root project))))))
  (dap-auto-configure-mode 1)
  ;; Build with cargo, then debug target/debug/<crate>
  (dap-register-debug-template
   "Rust :: gdb"
   (list :type "gdb"
         :request "launch"
         :name "Rust :: gdb"
         :program "${workspaceFolder}/target/debug/${workspaceFolderBasename}"
         :cwd "${workspaceFolder}"
         :dap-compilation "cargo build"
         :dap-compilation-dir "${workspaceFolder}"))
  (require 'dap-hydra)
  ;; Pop the hydra when the program stops
  (add-hook 'dap-stopped-hook (lambda (_arg) (call-interactively #'dap-hydra))))

(provide 'dap-mode-config)
;;; dap-mode-config.el ends here

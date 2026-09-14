;;; -*- lexical-binding: t -*-

;; Import shell env in GUI/daemon
(use-package exec-path-from-shell
  :ensure t
  :if (and (or (display-graphic-p) (daemonp))
           (not (member system-type '(ms-dos windows-nt cygwin haiku android))))
  :config
  (dolist (var '("SSH_AUTH_SOCK" "SSH_AGENT_PID" "GPG_AGENT_INFO" "LANG"
                 "LC_CTYPE" "GOPATH" "PYTHONPATH" "JAVA_HOME"))
    (add-to-list 'exec-path-from-shell-variables var))
  (exec-path-from-shell-initialize))

(provide 'exec-path-from-shell-config)
;;; exec-path-from-shell-config.el ends here

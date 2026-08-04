;;; -*- lexical-binding: t -*-

;; install some packages
(add-to-list 'package-selected-packages 'treesit-auto)
(add-to-list 'package-selected-packages 'aggressive-indent)
(add-to-list 'package-selected-packages 'ibuffer-project)

;; for "ms-dos windows cygwin haiku android" 's settings
(unless (member system-type '(ms-dos windows-nt cygwin haiku android))
  (add-to-list 'package-selected-packages 'exec-path-from-shell))

;; provide necessary feature
(provide 'crafted-ide-packages)
;;; crafted-ide-packages.el ends here

;;; -*- lexical-binding: t -*-

(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load custom-file nil :nomessage))

(add-to-list 'load-path (expand-file-name "modules" user-emacs-directory))

(require 'ui-config)
(require 'editing-config)
(require 'buffer-config)
(require 'completion-config)
(require 'ide-config)
(require 'org-config)
(require 'rust-config)

(load-theme 'modus-vivendi t)

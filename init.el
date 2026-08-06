;;; -*- lexical-binding: t -*-

;; Add modules directory to the load path so we can require config files
(add-to-list 'load-path (expand-file-name "modules" user-emacs-directory))

;; Load all configuration modules
(require 'helper-config)
(require 'redirect-file-config)
(require 'ui-config)
(require 'which-key-config)
(require 'editing-config)
(require 'buffer-config)
(require 'completion-config)
(require 'ide-config)
(require 'org-config)
(require 'rust-config)

;; Apply the dark high-contrast modus-vivendi theme
(load-theme 'modus-vivendi t)

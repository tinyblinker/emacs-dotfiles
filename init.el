;;; -*- lexical-binding: t -*-

(add-to-list 'load-path (expand-file-name "modules" user-emacs-directory))

(require 'helper-config)
(require 'redirect-file-config)
(require 'ui-config)
(require 'editing-config)
(require 'buffer-config)
(require 'completion-config)
(require 'ide-config)
(require 'org-config)
(require 'rust-config)

(load-theme 'modus-vivendi t)

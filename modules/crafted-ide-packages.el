;;; -*- lexical-binding: t -*-

(when (version< emacs-version "29")
  (add-to-list 'package-selected-packages 'eglot)

  (add-to-list 'package-selected-packages 'tree-sitter)
  (add-to-list 'package-selected-packages 'tree-sitter-indent)
  (add-to-list 'package-selected-packages 'tree-sitter-ispell)
  (add-to-list 'package-selected-packages 'tree-sitter-langs))

(when (version< "29" emacs-version)
  (add-to-list 'package-selected-packages 'treesit-auto))

(when (version< emacs-version "30")
  (add-to-list 'package-selected-packages 'editorconfig))

(add-to-list 'package-selected-packages 'aggressive-indent)

(add-to-list 'package-selected-packages 'ibuffer-project)

(unless (member system-type '(ms-dos windows-nt cygwin haiku android))
  (add-to-list 'package-selected-packages 'exec-path-from-shell))

(provide 'crafted-ide-packages)
;;; crafted-ide-packages.el ends here

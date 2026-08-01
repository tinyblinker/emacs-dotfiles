;;; crafted-lisp-config.el --- Lisp development configuration  -*- lexical-binding: t; -*-

;; Copyright (C) 2022
;; SPDX-License-Identifier: MIT

;; Author: System Crafters Community

;;; Code:

(require 'eldoc)

(when (locate-library "aggressive-indent")
  (add-hook 'lisp-mode-hook #'aggressive-indent-mode)
  (add-hook 'clojure-mode-hook #'aggressive-indent-mode)
  (add-hook 'scheme-mode-hook #'aggressive-indent-mode))

(when (locate-library "package-lint-flymake")
  (add-hook 'emacs-lisp-mode-hook #'package-lint-flymake-setup))


(with-eval-after-load 'sly
  (require 'sly-quicklisp "sly-quicklisp" :no-error)
  (require 'sly-repl-ansi-color "sly-repl-ansi-color" :no-error)
  (require 'sly-asdf "sly-asdf" :no-error))

(when (locate-library "sly")
  (add-hook 'lisp-mode-hook #'sly-editing-mode))


(with-eval-after-load "clojure-mode"
  (require 'cider "cider" :no-error)
  (require 'clj-refactor "clj-refactor" :no-error)

  (defun crafted-lisp-load-clojure-refactor ()
    "Load `clj-refactor' toooling and fix keybinding conflicts with cider."
    (when (locate-library "clj-refactor")
      (clj-refactor-mode 1)
      (cljr-add-keybindings-with-prefix "C-c r")))
  (add-hook 'clojure-mode-hook #'crafted-lisp-load-clojure-refactor)

  (with-eval-after-load "flycheck"
    (flycheck-clojure-setup)))


(customize-set-variable 'scheme-program-name "guile")


(provide 'crafted-lisp-config)
;;; crafted-lisp-config.el ends here

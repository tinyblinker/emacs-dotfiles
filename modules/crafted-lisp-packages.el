;;; crafted-lisp-packages.el --- Lisp development packages  -*- lexical-binding: t; -*-

;; Copyright (C) 2022
;; SPDX-License-Identifier: MIT

;; Author: System Crafters Community

;;; Code:

(add-to-list 'package-selected-packages 'aggressive-indent)

(add-to-list 'package-selected-packages 'package-lint)
(add-to-list 'package-selected-packages 'package-lint-flymake)

(add-to-list 'package-selected-packages 'sly)
(add-to-list 'package-selected-packages 'sly-asdf)
(add-to-list 'package-selected-packages 'sly-quicklisp)
(add-to-list 'package-selected-packages 'sly-repl-ansi-color)

(add-to-list 'package-selected-packages 'cider)
(add-to-list 'package-selected-packages 'clj-refactor)
(add-to-list 'package-selected-packages 'clojure-mode)
(add-to-list 'package-selected-packages 'flycheck-clojure)

(add-to-list 'package-selected-packages 'geiser)
(add-to-list 'package-selected-packages 'geiser-guile)
(add-to-list 'package-selected-packages 'geiser-racket)

(provide 'crafted-lisp-packages)
;;; crafted-lisp-packages.el ends here

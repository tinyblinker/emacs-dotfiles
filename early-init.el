;;; -*- lexical-binding: t -*-

;; Redirect native-comp cache into var/
(when (featurep 'native-compile)
  (startup-redirect-eln-cache
   (expand-file-name "var/eln-cache/" user-emacs-directory)))

;; JIT-compile .elc in background, silently
(setq native-comp-jit-compilation t
      native-comp-async-report-warnings-errors nil)

;; Disable GC during init
(setq gc-cons-threshold most-positive-fixnum
      gc-cons-percentage 0.6)
(add-hook 'emacs-startup-hook
          (lambda ()
            (setq gc-cons-threshold (* 100 1024 1024)
                  gc-cons-percentage 0.1)))

(require 'package)

;; No compile on install
(setq package-native-compile nil)

;; Package archives (mirrors first)
(setq package-archives
      '(("gnu-mirror" . "https://mirrors.ustc.edu.cn/elpa/gnu/")
        ("nongnu-mirror" . "https://mirrors.ustc.edu.cn/elpa/nongnu/")
        ("melpa-mirror" . "https://mirrors.ustc.edu.cn/elpa/melpa/")
        ("gnu"    . "https://elpa.gnu.org/packages/")
        ("nongnu" . "https://elpa.nongnu.org/nongnu/")
        ("melpa"  . "https://melpa.org/packages/")))

;; Prefer mirrors
(setq package-archive-priorities
      '(("gnu-mirror" . 99)
        ("gnu"    . 98)
        ("nongnu-mirror" . 80)
        ("nongnu" . 79)
        ("melpa-mirror"  . 70)
        ("melpa" . 69)))

;; Load all autoloads in one pass
(setq package-quickstart t)

(package-initialize)

;; Refresh archives if none
(unless package-archive-contents
  (package-refresh-contents))

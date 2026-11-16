;;; -*- lexical-binding: t -*-

;; Redirect native-comp cache into var/
(when (featurep 'native-compile)
  (startup-redirect-eln-cache
   (expand-file-name "var/eln-cache/" user-emacs-directory)))

;; JIT-compile .elc in background, not silently
(setq native-comp-jit-compilation t
      native-comp-async-report-warnings-errors t)

(require 'package)

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

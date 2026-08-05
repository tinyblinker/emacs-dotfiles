;;; -*- lexical-binding: t -*-

(require 'package)

(setq package-archives
      '(("gnu-mirror" . "https://mirrors.ustc.edu.cn/elpa/gnu/")
        ("nongnu-mirror" . "https://mirrors.ustc.edu.cn/elpa/nongnu/")
        ("melpa-mirror" . "https://mirrors.ustc.edu.cn/elpa/melpa/")
        ("gnu"    . "https://elpa.gnu.org/packages/")
        ("nongnu" . "https://elpa.nongnu.org/nongnu/")
        ("melpa"  . "https://melpa.org/packages/")))

(setq package-archive-priorities
      '(("gnu-mirror" . 99)
        ("gnu"    . 98)
        ("nongnu-mirror" . 80)
        ("nongnu" . 79)
        ("melpa-mirror"  . 70)
        ("melpa" . 69)))

(package-initialize)

(unless package-archive-contents
  (package-refresh-contents))

;;; -*- lexical-binding: t -*-

;; Disable garbage collection and file-name-handlers during init.
;; This avoids hundreds of tiny GC pauses and lets Emacs load files
;; without checking for remote/compressed paths on every I/O call.
;; Both are restored in emacs-startup-hook after init finishes.
(setq gc-cons-threshold most-positive-fixnum
      gc-cons-percentage 0.6)
(defvar file-name-handler-alist-original file-name-handler-alist)
(setq file-name-handler-alist nil)
(add-hook 'emacs-startup-hook
          (lambda ()
            (setq gc-cons-threshold (* 100 1024 1024)
                  gc-cons-percentage 0.1)
            (setq file-name-handler-alist
                  (delete-dups
                   (append file-name-handler-alist
                           file-name-handler-alist-original)))))

;; Set up package archives with mirrors for faster downloads in China
(require 'package)

(setq package-archives
      '(("gnu-mirror" . "https://mirrors.ustc.edu.cn/elpa/gnu/")
        ("nongnu-mirror" . "https://mirrors.ustc.edu.cn/elpa/nongnu/")
        ("melpa-mirror" . "https://mirrors.ustc.edu.cn/elpa/melpa/")
        ("gnu"    . "https://elpa.gnu.org/packages/")
        ("nongnu" . "https://elpa.nongnu.org/nongnu/")
        ("melpa"  . "https://melpa.org/packages/")))

;; Prefer mirrors over upstream to reduce download latency
(setq package-archive-priorities
      '(("gnu-mirror" . 99)
        ("gnu"    . 98)
        ("nongnu-mirror" . 80)
        ("nongnu" . 79)
        ("melpa-mirror"  . 70)
        ("melpa" . 69)))

;; Merge all package autoloads into one file so Emacs loads them in
;; a single pass instead of scanning every package directory one by one.
(setq package-quickstart t)

;; initialize the packages
(package-initialize)

;; if there is no archives, refresh the package-archives!
(unless package-archive-contents
  (package-refresh-contents))

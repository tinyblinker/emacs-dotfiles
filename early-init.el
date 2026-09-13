;;; -*- lexical-binding: t -*-

;; Redirect native-compile cache into var/ to keep the config directory clean
(when (featurep 'native-compile)
  (startup-redirect-eln-cache
   (expand-file-name "var/eln-cache/" user-emacs-directory)))

;; Native compilation: JIT-compile loaded .elc files asynchronously
;; (bytecode runs first, native code is compiled in the background and
;; hot-swapped in later), and keep that background compilation silent.
(setq native-comp-jit-compilation t
      native-comp-async-report-warnings-errors nil)

;; Disable garbage collection during init; restored in emacs-startup-hook.
;; (We intentionally do NOT nil out `file-name-handler-alist' here: that
;; legacy speed hack can interfere with native-comp `.eln' lookup and with
;; loading compressed `.el.gz' libraries.)
(setq gc-cons-threshold most-positive-fixnum
      gc-cons-percentage 0.6)
(add-hook 'emacs-startup-hook
          (lambda ()
            (setq gc-cons-threshold (* 100 1024 1024)
                  gc-cons-percentage 0.1)))

;; Set up package archives with mirrors for faster downloads in China
(require 'package)

;; Don't natively compile packages as part of their installation — they
;; are compiled on first load (async) and pre-warmed in the background by
;; `native-compile-async' at the end of init.el.  This keeps the first
;; install/startup from blocking on synchronous compilation.
(setq package-native-compile nil)

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

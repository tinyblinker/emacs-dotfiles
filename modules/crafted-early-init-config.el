;;; -*- lexical-binding: t; -*-

;; set package src "mirrors" and "priorities"
(require 'package)
(customize-set-variable 'package-archives '(("gnu" . "https://mirrors.ustc.edu.cn/elpa/gnu/")
                         ("melpa" . "https://mirrors.ustc.edu.cn/elpa/melpa/")
                         ("nongnu" . "https://mirrors.ustc.edu.cn/elpa/nongnu/")
                         ("stable" . "https://mirrors.ustc.edu.cn/elpa/stable-melpa/")))
(customize-set-variable 'package-archive-priorities
                        '(("gnu"    . 99)
                          ("nongnu" . 80)
                          ("stable" . 70)
                          ("melpa"  . 0)))

;; defvar to set default variables(overwrite by "early-init.el")
(defvar crafted-package-perform-stale-archive-check t
  "Check if any package archives are stale.

Set this value in your `early-init.el' file.")
(defvar crafted-package-update-days 1
  "Number of days before an archive will be considered stale.

Set this value in your `early-init.el' file")

;; helper function: if an archive is "stable"
(require 'time-date)
(defun crafted-package-archive-stale-p (archive)
  "Return t if ARCHIVE is stale.

ARCHIVE is stale if the on-disk cache is older than
`crafted-package-update-days' old.  If
`crafted-package-perform-stale-archive-check' is nil, the check
is skipped"
  (let* ((today (decode-time nil nil t))
         (archive-name (expand-file-name
                        (format "archives/%s/archive-contents" archive)
                        package-user-dir))
         (last-update-time (decode-time (file-attribute-modification-time
                                         (file-attributes archive-name))))
         (delta (make-decoded-time :day crafted-package-update-days)))
    (when crafted-package-perform-stale-archive-check
      (time-less-p (encode-time (decoded-time-add last-update-time delta))
                   (encode-time today)))))

;; helper funtion: Are all the archives stale?(based on "crafted-package-archive-stale-p")
(defun crafted-package-archives-stale-p ()
  "Return t if any package archives' cache is out of date.

Check each archive listed in `package-archives', if the on-disk
cache is older than `crafted-package-update-days', return a
non-nil value.  Fails fast, will return t for the first stale
archive found or nil if they are all up-to-date"
  (interactive)
  (cl-some #'crafted-package-archive-stale-p (mapcar #'car package-archives)))

;; helper function: Refreshing the packages cache based on "crafted-package-archives-stale-p"
(defun crafted-package-initialize ()
  "Initialize the package system.

Run this in the `before-init-hook'"

  (when package-enable-at-startup
    (package-initialize)

    (require 'seq)
    (message "crafted-package-config: checking package archives")
    (cond ((seq-empty-p package-archive-contents)
           (progn
             (message "crafted-package-config: package archives empty, initalizing")
             (package-refresh-contents)))
          ((crafted-package-archives-stale-p)
           (progn
             (message "crafted-package-config: package archives stale, refreshing")
             (package-refresh-contents t))))
    (message "crafted-package-config: package system initialized!")))

;; add hook
(add-hook 'before-init-hook #'crafted-package-initialize)

;; provide the necessary feature
(provide 'crafted-early-init-config)
;;; crafted-early-init-config.el ends here

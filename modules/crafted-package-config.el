;;; -*- lexical-binding: t -*-

;; load the "package"
(require 'package)

;; define the package installer's variables
(defvar crafted-package-installer #'package-install
  "Function to use when installing packages")
(defvar crafted-package-installed-predicate #'package-installed-p
  "Function to use when checking if a package is installed")

;; if a pkg not installed, then install it
(defun crafted-package-install-package (package &optional installer-fn predicate-fn)
  "Install PACKAGE optionally using the INSTALLER-FN.

Uses the PREDICATE-FN to check if a package is already installed
before installing it.  Default values for both the PREDICATE-FN an
INSTALLER-FN are held in the
`crafted-package-installed-predicate' and
`crafted-package-installer' variables."
  (let ((checker (or predicate-fn crafted-package-installed-predicate))
        (installer (or installer-fn crafted-package-installer)))
    (unless (funcall checker package)
      (funcall installer package))))

;; if user use the package.el, then just install pkgs in "packages-selected-packages"
(defun crafted-package-install-selected-packages ()
  "Installs all packages listed in the `package-selected-packages' list.

If `crafted-package-installer' has been customized, use it to
install packages one at at time from the list
`package-selected-packages', otherwise use the built-in
`package-install-selected-packages', which is purpose built for
this."
  (if (eq #'package-install crafted-package-installer)
      (package-install-selected-packages t)
    (mapc #'crafted-package-install-package package-selected-packages)))

;; provide necessary feature
(provide 'crafted-package-config)
;;; crafted-package-config.el ends here

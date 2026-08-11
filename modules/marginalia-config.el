;;; -*- lexical-binding: t -*-

;;; Marginalia: enrich minibuffer completion candidates with detailed annotations
;;;
;;; Without Marginalia, completion only shows bare names. With it enabled:
;;;   - Files  → show permissions, owner, size, modification date
;;;   - Buffers → show major mode, file path, modification status
;;;   - Commands → show keybinding and first line of docstring
;;;   - Variables → show current value and type
;;;   - Packages → show version, archive, and description
;;;   - Bookmarks → show file path and surrounding context
;;;   - Faces → show a live color sample
;;;
;;; Press `M-x marginalia-cycle' while the minibuffer is open to rotate through
;;; alternative annotators for the current completion category.
(use-package marginalia
  :ensure t
  :config
  (marginalia-mode 1))               ;; Enable rich annotations globally

(provide 'marginalia-config)
;;; marginalia-config.el ends here

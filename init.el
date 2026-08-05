;;; -*- lexical-binding: t -*-

(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load custom-file nil :nomessage))

(defun add-lexical-binding-to-file ()
  (interactive)
  (save-excursion
    (goto-char (point-min))
    (if (looking-at-p ".*lexical-binding.*")
        (message "already had the 'lexical-binding'")
      (insert ";;; -*- lexical-binding: t -*-\n\n")
      (message "added successfully"))))

(add-to-list 'load-path (expand-file-name "modules" user-emacs-directory))

(require 'ui-config)
(require 'editing-config)
(require 'buffer-config)
(require 'completion-config)
(require 'ide-config)
(require 'org-config)

(load-theme 'modus-vivendi t)

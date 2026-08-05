;;; -*- lexical-binding: t -*-

(defun add-lexical-binding-to-file ()
  (interactive)
  (save-excursion
    (goto-char (point-min))
    (if (looking-at-p ".*lexical-binding.*")
        (message "already had the 'lexical-binding'")
      (insert ";;; -*- lexical-binding: t -*-\n\n")
      (message "added successfully"))))

(provide 'helper-config)
;;; helper-config.el ends here

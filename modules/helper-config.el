;;; -*- lexical-binding: t -*-

;; Insert lexical-binding header
(defun add-lexical-binding-to-file ()
  (interactive)
  (save-excursion
    (goto-char (point-min))
    (if (looking-at-p ".*lexical-binding.*")
        (message "already had the 'lexical-binding'")
      (insert ";;; -*- lexical-binding: t -*-\n\n")
      (message "added successfully"))))

;; Convert fullwidth CJK to halfwidth ASCII
(defconst fullwidth-to-halfwidth-extra-table
  '(("【" . "[") ("】" . "]")
    ("「" . "'") ("」" . "'")
    ("『" . "\"") ("』" . "\"")
    ("《" . "<") ("》" . ">")
    ("。" . ".") ("、" . ","))
  "Extra CJK punctuation not covered by the U+FF00 halfwidth block.")

(defun fullwidth-to-halfwidth (beg end)
  "Convert fullwidth characters between BEG and END to halfwidth ASCII."
  (interactive (if (use-region-p)
                   (list (region-beginning) (region-end))
                 (list (point-min) (point-max))))
  (save-excursion
    (save-restriction
      (narrow-to-region beg end)
      (goto-char (point-min))
      ;; FF01-FF5E -> ASCII; 3000 -> space
      (while (re-search-forward "[\uFF01-\uFF5E\u3000]" nil t)
        (let ((ch (char-before)))
          (replace-match (string (if (= ch ?\u3000) ?\s (- ch #xFEE0))))))
      ;; Extra CJK punctuation
      (goto-char (point-min))
      (dolist (pair fullwidth-to-halfwidth-extra-table)
        (goto-char (point-min))
        (while (search-forward (car pair) nil t)
          (replace-match (cdr pair) nil t))))))

(global-set-key (kbd "C-c C-t p") #'fullwidth-to-halfwidth)

(provide 'helper-config)
;;; helper-config.el ends here

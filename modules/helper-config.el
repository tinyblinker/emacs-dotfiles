;;; -*- lexical-binding: t -*-

;; Command to insert lexical-binding header into the current buffer
(defun add-lexical-binding-to-file ()
  (interactive)
  (save-excursion
    (goto-char (point-min))
    (if (looking-at-p ".*lexical-binding.*")
        (message "already had the 'lexical-binding'")
      (insert ";;; -*- lexical-binding: t -*-\n\n")
      (message "added successfully"))))

;;; Convert fullwidth CJK punctuation/letters to halfwidth ASCII
;;; (e.g. Chinese brackets （） to English (), ， to , etc.)
;;; Works on the active region, or the whole buffer if no region is active.
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
      ;; U+FF01..U+FF5E map to ASCII by subtracting #xFEE0;
      ;; U+3000 (ideographic space) maps to a plain space.
      (while (re-search-forward "[\uFF01-\uFF5E\u3000]" nil t)
        (let ((ch (char-before)))
          (replace-match (string (if (= ch ?\u3000) ?\s (- ch #xFEE0))))))
      ;; Handle the CJK-specific punctuation that falls outside that block.
      (goto-char (point-min))
      (dolist (pair fullwidth-to-halfwidth-extra-table)
        (goto-char (point-min))
        (while (search-forward (car pair) nil t)
          (replace-match (cdr pair) nil t))))))

(global-set-key (kbd "C-c C-t p") #'fullwidth-to-halfwidth)

(provide 'helper-config)
;;; helper-config.el ends here

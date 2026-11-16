;;; -*- lexical-binding: t -*-
(defun my/toggle-truncate-of-line ()
  "toggle truncate of the lines"
  (interactive)
  (if truncate-lines
      (progn
        (visual-line-mode 1)
        (message "disable truncate-wrapper"))
    (progn
      (visual-line-mode -1)
      (setq-local truncate-lines t)
      (message "enable truncate-wrapper"))))

(defun my/add-lexical-binding-to-file ()
  "Insert lexical-binding header"
  (interactive)
  (save-excursion
    (goto-char (point-min))
    (if (looking-at-p ".*lexical-binding.*")
        (message "already had the 'lexical-binding'")
      (insert ";;; -*- lexical-binding: t -*-\n\n")
      (message "added successfully"))))

(defun my/insert-emacs-config-template()
  "Insert Emacs config template in current buffer"
  (interactive)
  (let* ((filename (file-name-nondirectory (buffer-file-name)))
         (header ";;; -*- lexical-binding: t -*-")
         (feature (format "(provide '%s)"
                          (substring filename 0
                                     (or (string-search "." filename) (length filename)))))
         (footer (format ";;; %s ends here" filename)))
    (erase-buffer)
    (insert header "\n\n")
    (insert feature "\n")
    (insert footer)))

(defconst fullwidth-to-halfwidth-extra-table
  '(("【" . "[") ("】" . "]")
    ("「" . "'") ("」" . "'")
    ("『" . "\"") ("』" . "\"")
    ("《" . "<") ("》" . ">")
    ("。" . ".") ("、" . ",")
    ("“" . "\""))
  "Extra CJK punctuation not covered by the U+FF00 halfwidth block.")

(defun my/fullwidth-to-halfwidth (beg end)
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

(provide 'myhelpers-config)
;;; myhelpers-config.el ends here

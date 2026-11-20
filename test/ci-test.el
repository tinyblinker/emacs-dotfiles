;;; -*- lexical-binding: t -*-

;; check syntax
(let ((files (process-lines "git" "ls-files" "*.el")))
  (unless files
    (error "ci: no files"))
  (dolist (file files)
    (condition-case err
        (with-temp-buffer
          (insert-file-contents file)
          (emacs-lisp-mode)
          (check-parens)
          (goto-char (point-min))
          (condition-case nil
              (while t
                (read (current-buffer)))
            (end-of-file nil)))
      (error
       (error "ci: %s: %s" file (error-message-string err))))))

;; check success
(message "ci: ok")

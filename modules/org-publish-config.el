;;; -*- lexical-binding: t -*-
(defun my/org-html-snippet (name)
  "Return the contents of snippets/NAME."
  (my/read-file-as-string
   (expand-file-name name
                     (expand-file-name "snippets" user-emacs-directory))))

(defun my/org-html-head (_info)
  "Return the custom HTML head."
  (my/org-html-snippet "html-head.html"))

(defun my/org-html-preamble (info)
  "Return the custom HTML preamble with Org specifiers expanded."
  (format-spec (my/org-html-snippet "html-preamble.html")
               (org-html-format-spec info)))

(defun my/org-html-postamble (info)
  "Return the custom HTML postamble with Org specifiers expanded."
  (format-spec (my/org-html-snippet "html-postamble.html")
               (org-html-format-spec info)))

(defun my/org-link-org-file-path (path)
  "Return non-nil if PATH names an Org file (case-insensitive extension)."
  (and path
       (let ((ext (file-name-extension path)))
         (and ext (string-equal ext "org")))))

(defun my/org-link-target (link file)
  "Return the absolute Org target of LINK in FILE, or nil."
  (let* ((type (org-element-property :type link))
         (path (org-element-property :path link))
         (p (and path (org-link-unescape path)))
         (dir (file-name-directory path)))
    (when path
      (cond
       ((member type '("id"))
        (let ((file (org-id-find-id-file path)))
          (and file
               (file-regular-p file)
               (my/org-link-org-file-path file)
               file)))
       ((member type '("file"))
        (let ((file (expand-file-name p dir)))
          (and file
               (file-regular-p file)
               (my/org-link-org-file-path file)
               file)))
       (t nil)))))

(defun my/org-reachable-files (entry)
  "Return all Org files reachable from ENTRY via id:, file: and fuzzy links.
ENTRY is an absolute file name. Follow links transitively."
  (unless (file-exists-p entry)
    (user-error "Entry file does not exist: %s" entry))
  (let* ((org-dir (expand-file-name "org" user-emacs-directory))
         (entry-file entry)
         (all-org-files (directory-files-recursively org-dir "\\.org\\'"))
         (seen (make-hash-table :test #'equal))
         (queue (list entry-file))
         (unresolved nil)
         result)
    (org-id-update-id-locations all-org-files nil)
    (while queue
      (let* ((file (pop queue)))
        (unless (gethash (file-truename file) seen)
          (puthash (file-truename file) t seen)
          (push file result)
          (with-temp-buffer
            (insert-file-contents file)
            (let ((org-inhibit-startup t))
              (delay-mode-hooks (org-mode))
              (org-element-map (org-element-parse-buffer) 'link
                (lambda (link)
                  (let ((target (my/org-link-target link file)))
                    (cond
                     ((and target
                           (file-regular-p target)
                           (file-in-directory-p target org-dir)
                           (string-suffix-p ".org" target)
                           (not (gethash (file-truename target) seen)))
                      (push target queue))
                     ((null target)
                      (push (list (file-relative-name file org-dir)
                                  (org-element-property :raw-link link))
                            unresolved)))))))))))
    (when unresolved
      (message "Unresolved Org links:\n%s"
               (mapconcat (lambda (item)
                            (format "  %s: %s" (car item) (cadr item)))
                          (nreverse (delete-dups unresolved)) "\n")))
    (nreverse result)))

(defun my/org-publish-copy-style (output-dir)
  "Copy snippets/style.css to OUTPUT-DIR/style.css."
  (let ((source (expand-file-name "snippets/style.css" user-emacs-directory))
        (target (expand-file-name "style.css" output-dir)))
    (unless (file-exists-p source)
      (user-error "Missing stylesheet: %s" source))
    (make-directory output-dir t)
    (copy-file source target t)))

(defun my/add-reachable-file-before-org-publish ()
  "Edit the 'org-publish-project-alist' based on
'my/org-reachable-files''s reachable files list."
  (let* ((entry (buffer-file-name))
         (reachable-files (my/org-reachable-files entry))
         (project (assoc "blog" org-publish-project-alist)))
    (setcdr project (plist-put (cdr project) :include reachable-files))))

(defun my/before-org-publish-advice ()
  "Advice for let us publish the current buffer and
exactly all the related org files."
  (let ((project (assoc "blog" org-publish-project-alist))
        (output-dir (plist-get (cdr project) :publishing-directory)))
    (my/add-reachable-file-before-org-publish)
    (my/org-publish-copy-style output-dir)))

(use-package ox-publish
  :ensure nil
  :config
  (advice-add 'org-publish :before #'my/before-org-publish-advice)
  (setq org-export-with-sub-superscripts nil) ;; don't treat "_" as sub superscripts
  (setq org-export-with-broken-links 'mark)   ;; mark the 'broken links'
  (setq org-publish-project-alist
        `(("blog"
           :base-directory ,(expand-file-name "org" user-emacs-directory)
           :base-extension "org"
           :exclude ".*"
           :recursive t
           :publishing-directory ,(expand-file-name "blog" user-emacs-directory)
           :publishing-function org-html-publish-to-html
           ;; html5
           :html-doctype "html5"
           :html-html5-fancy t
           ;; disable some Org's default StyleSheet(css) & Scripts
           :html-head-include-scripts nil
           :html-head-include-default-style nil
           ;; use customed StyleSheet(css)
           :html-head my/org-html-head
           ;; html preamble & postamble
           :html-preamble my/org-html-preamble
           :html-postamble my/org-html-postamble)
          ("static"
           :base-directory ,(expand-file-name "org" user-emacs-directory)
           :base-extension "css\\|txt\\|jpg\\|gif\\|png\\|svg\\|jpeg\\|webp"
           :recursive t
           :publishing-directory ,(expand-file-name "blog" user-emacs-directory)
           :publishing-function org-publish-attachment)
          ("tinyblinker.org"
           :components ("blog" "static")))))

(provide 'org-publish-config)
;;; org-publish-config.el ends here

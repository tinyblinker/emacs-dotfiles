;;; -*- lexical-binding: t -*-
(defvar current-buffer nil
  "The 'buffer-file-name' in which 'org-publish' is executed.")

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
  (let* ((entry-file entry)
         (all-org-files (directory-files-recursively org-dir "\\.org\\'"))
         (seen (make-hash-table :test #'equal))
         (queue (list entry-file))
         (unresolved nil)
         result)
    (org-id-update-id-locations all-org-files t)
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

(defun my/org-publish-write-index-redirect (current-file)
  "Use a index.html, redirect to the 'current-file' in output-dir."
  (let* ((output-dir (plist-get
                      (cdr (assoc "blog" org-publish-project-alist))
                      :publishing-directory))
         (target-html-file (expand-file-name
                            (file-relative-name
                             (concat (file-name-sans-extension current-file) ".html")
                             org-dir)
                            output-dir))
         (relative (file-relative-name target-html-file output-dir)))
    (unless (file-exists-p target-html-file)
      (user-error "'target-html-file' does not exist: %s" target-html-file))
    (with-temp-file (expand-file-name "index.html" output-dir)
      (insert (format
               (my/read-file-as-string (expand-file-name
                                        "snippets/index-format.html" user-emacs-directory))
               relative relative)))))

(defun my/add-reachable-file-before-org-publish (entry)
  "Edit the 'org-publish-project-alist' based on
'my/org-reachable-files''s reachable files list."
  (let* ((reachable-files (my/org-reachable-files entry))
         (project (assoc "blog" org-publish-project-alist)))
    (setcdr project (plist-put (cdr project) :include reachable-files))))

(defun my/before-org-publish-advice (&rest _args)
  "Advice that let us publish the current org-buffer and
just all the linked org files."
  (setq current-buffer (buffer-file-name))
  (unless (not (null current-buffer))
    (user-error "'current-buffer' is nil!"))
  (unless (and (file-in-directory-p current-buffer org-dir)
               (not noninteractive)
               (derived-mode-p 'org-mode))
    (user-error "%s is not in the %s OR in noninteractive OR the buffer is not in org-mode."
                current-buffer org-dir))
  (unless (y-or-n-p (format "Use %s as 'index.html'?" current-buffer))
    (setq current-buffer nil)
    (user-error "User abort the selection of 'current-buffer'"))
  (let* ((project (assoc "blog" org-publish-project-alist))
         (output-dir (plist-get (cdr project) :publishing-directory)))
    (my/add-reachable-file-before-org-publish current-buffer)))

(defun my/after-org-publish-advice (&rest _args)
  "Advice for things to do after the 'org-publish'."
  (let* ((project (assoc "blog" org-publish-project-alist))
         (output-dir (plist-get (cdr project) :publishing-directory)))
    (my/org-publish-copy-style output-dir)
    (my/org-publish-write-index-redirect current-buffer)))

(use-package ox-publish
  :ensure nil
  :config
  (advice-add 'org-publish :before #'my/before-org-publish-advice)
  (advice-add 'org-publish :after #'my/after-org-publish-advice)
  (setq org-export-with-sub-superscripts nil) ;; don't treat "_" as sub superscripts
  (setq org-export-with-broken-links 'mark)   ;; mark the 'broken links'
  (setq org-publish-use-timestamps-flag nil)  ;; ignore the cache, re-generate all every time
  (setq org-export-preserve-breaks t)         ;; treat breaks as '\n'
  (setq org-export-use-babel nil)             ;; do not executed babel
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
           :html-head ,(my/read-file-as-string
                        (expand-file-name "snippets/html-head.html" user-emacs-directory))
           ;; html preamble & postamble
           :html-preamble ,(my/read-file-as-string
                            (expand-file-name "snippets/html-preamble.html" user-emacs-directory))
           :html-postamble ,(my/read-file-as-string
                             (expand-file-name "snippets/html-postamble.html" user-emacs-directory)))
          ("static"
           :base-directory ,(expand-file-name "org" user-emacs-directory)
           :base-extension "css\\|txt\\|jpg\\|gif\\|png\\|svg\\|jpeg\\|webp"
           :recursive t
           :publishing-directory ,(expand-file-name "blog" user-emacs-directory)
           :publishing-function org-publish-attachment)
          ("tinyblinker.org"
           :components ("blog" "static"))))
  (defvar org-dir (plist-get
                   (cdr (assoc "blog" org-publish-project-alist))
                   :base-directory)
    "Org notes' base dir."))

(provide 'org-publish-config)
;;; org-publish-config.el ends here

;;; -*- lexical-binding: t -*-
(require 'ox-publish)
(require 'ox-html)
(require 'org-id)

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

(use-package ox-publish
  :ensure nil
  :config
  (setq org-export-with-sub-superscripts nil) ;; don't treat "_" as sub superscripts
  (setq org-export-with-broken-links 'mark)   ;; mark the 'broken links'
  (setq org-publish-project-alist
        `(("blog"
           :base-directory ,(expand-file-name "org" user-emacs-directory)
           :base-extension "org"
           :recursive t
           :exclude "capture/\\|sitemap\\.org"
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
           :exclude "capture/"
           :publishing-directory ,(expand-file-name "blog" user-emacs-directory)
           :publishing-function org-publish-attachment)
          ("tinyblinker.org"
           :components ("blog" "static")))))

(defun my/org-publish-excluded-p (file org-dir)
  "Return non-nil if FILE under ORG-DIR should not be published."
  (let ((relative (file-relative-name file org-dir)))
    (or (string-prefix-p "capture/" relative)
        (string= relative "sitemap.org"))))

(defun my/org-link-target (link file)
  "Return the absolute Org target of LINK in FILE, or nil."
  (let* ((type (org-element-property :type link))
         (raw (org-element-property :path link))
         (path (and raw (car (split-string raw "::")))))
    (pcase type
      ("id"
       (when (and path org-id-locations)
         (when-let* ((location (gethash path org-id-locations)))
           (expand-file-name location))))
      ((or "file" "fuzzy")
       (when path
         (let ((target (expand-file-name (org-link-unescape path)
                                         (file-name-directory file))))
           (and (equal (file-name-extension target) "org")
                (file-exists-p target)
                target)))))))

(defun my/org-link-org-file-p (link)
  "Return non-nil if LINK points to an Org file or ID."
  (let* ((type (org-element-property :type link))
         (raw (org-element-property :path link))
         (path (and raw (car (split-string raw "::")))))
    (or (string= type "id")
        (and (member type '("file" "fuzzy"))
             path
             (equal (file-name-extension path) "org")))))

(defun my/org-reachable-files (entry &optional max-depth)
  "Return Org files reachable from ENTRY via id:, file: and fuzzy links.
ENTRY is relative to the `org' directory.  MAX-DEPTH nil means follow
links transitively, 1 means only direct links, and 0 means only ENTRY."
  (let* ((org-dir (expand-file-name "org" user-emacs-directory))
         (entry-file (expand-file-name entry org-dir))
         (all-org-files (directory-files-recursively org-dir "\\.org\\'"))
         (org-id-locations (org-id-update-id-locations all-org-files t))
         (seen (make-hash-table :test #'equal))
         (queue (list (cons entry-file 0)))
         (unresolved nil)
         result)
    (unless (file-exists-p entry-file)
      (user-error "Entry file does not exist: %s" entry-file))
    (while queue
      (let* ((item (pop queue))
             (file (car item))
             (depth (cdr item))
             (true-file (file-truename file)))
        (unless (gethash true-file seen)
          (puthash true-file t seen)
          (push file result)
          (when (or (null max-depth) (< depth max-depth))
            (with-temp-buffer
              (insert-file-contents file)
              (let ((org-inhibit-startup t))
                (delay-mode-hooks (org-mode))
                (org-element-map (org-element-parse-buffer) 'link
                  (lambda (link)
                    (let ((target (my/org-link-target link file)))
                      (cond
                       ((and target
                             (file-in-directory-p target org-dir)
                             (not (my/org-publish-excluded-p target org-dir)))
                        (let ((true-target (file-truename target)))
                          (unless (gethash true-target seen)
                            (push (cons target (1+ depth)) queue))))
                       ((and (null target)
                             (my/org-link-org-file-p link))
                        (push (list (file-relative-name file org-dir)
                                    (org-element-property :raw-link link))
                              unresolved))))))))))))
    (when unresolved
      (message "Unresolved Org links:\n%s"
               (mapconcat (lambda (item)
                            (format "  %s: %s" (car item) (cadr item)))
                          (nreverse (delete-dups unresolved)) "\n")))
    (nreverse result)))

(defun my/org-publish-prune (org-dir output-dir files)
  "Remove generated note HTML under OUTPUT-DIR that is not in FILES."
  (let ((expected (mapcar (lambda (file)
                            (concat (file-name-sans-extension
                                     (file-relative-name file org-dir))
                                    ".html"))
                          files))
        (notes-dir (expand-file-name "notes" output-dir)))
    (when (file-directory-p notes-dir)
      (dolist (file (directory-files-recursively notes-dir "\\.html\\'"))
        (unless (member (file-relative-name file output-dir) expected)
          (delete-file file))))
    (let ((sitemap (expand-file-name "sitemap.html" output-dir)))
      (when (file-exists-p sitemap)
        (delete-file sitemap)))))

(defun my/org-publish-blog (&optional force)
  "Publish index.org and the Org files reachable from it."
  (interactive "P")
  (require 'ox-publish)
  (require 'org-id)
  (let* ((org-dir (expand-file-name "org" user-emacs-directory))
         (files (my/org-reachable-files "index.org"))
         (include (mapcar (lambda (file)
                            (file-relative-name file org-dir))
                          files))
         (project (copy-tree (assoc "blog" org-publish-project-alist))))
    (unless files
      (user-error "No reachable Org files from index.org"))
    ;; Publish exactly the reachable files, then copy static assets.
    (setcdr project (plist-put (cdr project) :recursive nil))
    (setcdr project (plist-put (cdr project) :exclude ".*"))
    (setcdr project (plist-put (cdr project) :include include))
    (setcdr project (plist-put (cdr project) :auto-sitemap nil))
    (let ((org-confirm-babel-evaluate nil))
      (org-publish-project project force)
      (org-publish-project (assoc "static" org-publish-project-alist) force)
      (my/org-publish-prune org-dir
                            (org-publish-property :publishing-directory project)
                            files))))

(provide 'org-publish-config)
;;; org-publish-config.el ends here

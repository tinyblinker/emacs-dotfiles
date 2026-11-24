;;; -*- lexical-binding: t -*-
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

(defun my/org-publish-entry ()
  "Return the current Org file as the publication root after confirmation.
Return nil when not in an Org buffer under the `org' directory, when
running in batch mode, or when the user declines."
  (let* ((org-dir (expand-file-name "org" user-emacs-directory))
         (current-file-path (buffer-file-name)))
    (cond
     ((not (and (file-in-directory-p current-file-path org-dir)
                (derived-mode-p 'org-mode)
                (not noninteractive)))
      (let ((text-quoting-style 'straight))
        (message "Not in Org-buffer in the 'org/' in user-emacs-directory"))
      nil)
     ((y-or-n-p (format "Use %s as index.org? " current-file-path))
      current-file-path)
     (t
      (message "Abort by user.")
      nil))))

(defun my/org-reachable-files (entry)
  "Return all Org files reachable from ENTRY via id:, file: and fuzzy links.
ENTRY is relative to the `org' directory, or an absolute file name.
Follow links transitively."
  (let* ((org-dir (expand-file-name "org" user-emacs-directory))
         (entry-file (expand-file-name entry org-dir))
         (all-org-files (directory-files-recursively org-dir "\\.org\\'"))
         (org-id-locations (org-id-update-id-locations all-org-files t))
         (seen (make-hash-table :test #'equal))
         (queue (list entry-file))
         (unresolved nil)
         result)
    (unless (file-exists-p entry-file)
      (user-error "Entry file does not exist: %s" entry-file))
    (while queue
      (let* ((file (pop queue))
             (true-file (file-truename file)))
        (unless (gethash true-file seen)
          (puthash true-file t seen)
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
                           (file-in-directory-p target org-dir))
                      (let ((true-target (file-truename target)))
                        (unless (gethash true-target seen)
                          (push target queue))))
                     ((and (null target)
                           (my/org-link-org-file-p link))
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

(defun my/org-publish-index-copy (org-dir output-dir entry)
  "Use ENTRY's generated page as index.html under OUTPUT-DIR."
  (let* ((index (expand-file-name "index.org" org-dir))
         (relative (file-relative-name entry org-dir))
         (source (expand-file-name
                  (concat (file-name-sans-extension relative) ".html")
                  output-dir))
         (target (expand-file-name "index.html" output-dir))
         (base (or (file-name-directory relative) "")))
    (unless (file-equal-p entry index)
      (unless (file-exists-p source)
        (user-error "Missing generated page: %s" source))
      (let ((html (with-temp-buffer
                    (insert-file-contents source)
                    (buffer-string))))
        (unless (member base '("" "./"))
          (setq html
                (replace-regexp-in-string
                 "\\(href\\|src\\)=\"\\([^\"]+\\)\""
                 (lambda (match)
                   (let ((attribute (match-string 1 match))
                         (url (match-string 2 match)))
                     (if (or (string-empty-p url)
                             (string-prefix-p "#" url)
                             (string-prefix-p "/" url)
                             (string-match-p
                              "\\`[[:alpha:]][[:alnum:]+.-]*:" url))
                         match
                       (format "%s=\"%s%s\"" attribute base url))))
                 html t t)))
        (with-temp-file target
          (insert html))))))

(defun my/org-publish-prune (org-dir output-dir files)
  "Remove generated subdirectory HTML under OUTPUT-DIR not in FILES."
  (let ((expected (mapcar (lambda (file)
                            (concat (file-name-sans-extension
                                     (file-relative-name file org-dir))
                                    ".html"))
                          files)))
    (when (file-directory-p output-dir)
      (dolist (file (directory-files-recursively output-dir "\\.html\\'"))
        (let ((relative (file-relative-name file output-dir)))
          (when (and (string-match-p "/" relative)
                     (not (member relative expected)))
            (delete-file file)))))
    (let ((sitemap (expand-file-name "sitemap.html" output-dir)))
      (when (file-exists-p sitemap)
        (delete-file sitemap)))))

(defun my/org-publish-blog (&optional force)
  "Publish the current Org file and its full link closure.
Abort without publishing when not in an Org buffer under the `org'
directory, in batch mode, or when the user declines."
  (interactive "P")
  (require 'ox-publish)
  (require 'org-id)
  (when-let* ((entry (my/org-publish-entry)))
    (let* ((org-dir (expand-file-name "org" user-emacs-directory))
           (files (my/org-reachable-files entry))
           (project (assoc "blog" org-publish-project-alist))
           (output-dir (org-publish-property :publishing-directory project)))
      (unless files
        (user-error "No reachable Org files from %s" entry))
      (let ((org-confirm-babel-evaluate nil)
            (org-publish-use-timestamps-flag (not force)))
        (org-publish-initialize-cache "blog")
        (dolist (file files)
          (org-publish-file file project t))
        (org-publish-write-cache-file)
        (org-publish-project (assoc "static" org-publish-project-alist) force)
        (my/org-publish-prune org-dir output-dir files)
        (my/org-publish-index-copy org-dir output-dir entry)
        (my/org-publish-copy-style output-dir)))))

(provide 'org-publish-config)
;;; org-publish-config.el ends here

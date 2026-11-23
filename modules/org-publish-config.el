;;; -*- lexical-binding: t -*-
(use-package ox-publish
  :ensure nil
  :defer t
  :config
  (setq org-export-with-sub-superscripts nil) ;; don't treat "_" as sub superscripts
  (setq org-export-with-broken-links 'mark)   ;; mark the 'broken links'
  (setq org-export-global-macros
        '(("timestamp" . "@@html:<span class=\"timestamp\">[$1]</span>@@")))
  (setq org-publish-project-alist
        `(;; ("pages"
          ;;  :base-directory ,(expand-file-name "org" user-emacs-directory)
          ;;  :base-extension "org"
          ;;  :recursive nil
          ;;  :publishing-directory ,(expand-file-name "blog" user-emacs-directory)
          ;;  :publishing-function org-html-publish-to-html)
          ("blog"
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
           :html-head ,(my/read-file-as-string
                        (expand-file-name "snippets/html-head.html" user-emacs-directory))
           ;; html preamble & postamble
           :html-preamble ,(my/read-file-as-string
                            (expand-file-name "snippets/html-preamble.html" user-emacs-directory))
           :html-postamble ,(my/read-file-as-string
                             (expand-file-name "snippets/html-postamble.html" user-emacs-directory))
           ;; Sitemap settings
           :auto-sitemap t
           :sitemap-title "Blog Posts"
           :sitemap-filename "sitemap.org"
           :sitemap-sort-files anti-chronologically
           :sitemap-format-entry my/org-sitemap-date-entry-format)
          ("static"
           :base-directory ,(expand-file-name "org" user-emacs-directory)
           :base-extension "css\\|txt\\|jpg\\|gif\\|png\\|svg\\|jpeg\\|webp"
           :recursive t
           :publishing-directory ,(expand-file-name "blog" user-emacs-directory)
           :publishing-function org-publish-attachment)
          ("tinyblinker.org"
           :components ("blog" "static")))))

;; My helper function to identify reachable files base on a assigned main page
(defun my/org-reachable-files (entry)
  "Return Org files reachable from ENTRY via id: and file: links."
  (let* ((seen (make-hash-table :test #'equal))
         (ids (make-hash-table :test #'equal))
         (org-dir (expand-file-name "org" user-emacs-directory))
         (all-org-files (directory-files-recursively org-dir "\\.org$"))
         (queue (list (expand-file-name entry org-dir)))
         result)
    ;; ids(hashmap):[ID -> file]
    (dolist (file all-org-files)
      (with-temp-buffer
        (insert-file-contents file)
        (goto-char (point-min))
        (when (re-search-forward "^:ID:[ \t]+\\([^ \t\n]+\\)" nil t)
          (puthash (match-string-no-properties 1) file ids))))
    ;; stack(do sth. with queue)
    (while queue
      (let ((file (pop queue)))
        (unless (gethash file seen)
          (puthash file t seen)
          (push file result)
          (with-temp-buffer
            (insert-file-contents file)
            (org-mode)
            (org-element-map (org-element-parse-buffer) 'link
              (lambda (link)
                (let ((type (org-element-property :type link))
                      (path (org-element-property :path link)))
                  (pcase type
                    ("id"
                     (when-let* ((target (gethash path ids)))
                       (unless (gethash target seen)
                         (push target queue))))
                    ("file"
                     (let* ((path (car (split-string path "::")))
                            (target (expand-file-name
                                     path (file-name-directory file))))
                       (when (and (string= (file-name-extension target) "org")
                                  (file-exists-p target)
                                  (not (gethash target seen)))
                         (push target queue))))))))))))
    (nreverse result)))

;; My helper function to publish my orgs as blogs
(defun my/org-publish-blog (&optional force)
  (interactive "P")
  (require 'ox-publish)
  (let* ((org-dir (expand-file-name "org" user-emacs-directory))
         (project (assoc "blog" org-publish-project-alist))
         (files (my/org-reachable-files "index.org"))
         (org-publish-use-timestamps-flag
          (if force nil org-publish-use-timestamps-flag)))
    (org-id-update-id-locations
     (directory-files-recursively org-dir "\\.org$"))
    (org-publish-initialize-cache "blog")
    (dolist (file files)
      (org-publish-file file project t))
    (org-publish-write-cache-file)
    (org-publish-project (assoc "static" org-publish-project-alist))))

(provide 'org-publish-config)
;;; org-publish-config.el ends here

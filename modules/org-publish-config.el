;;; -*- lexical-binding: t -*-
(use-package ox-publish
  :ensure nil
  :defer t
  :config
  (setq org-publish-project-alist
        `(("pages"
           :base-directory ,(expand-file-name "org/notes" user-emacs-directory)
           :base-extension "org"
           :recursive t
           :publishing-directory ,(expand-file-name "html" user-emacs-directory)
           :publishing-function org-html-publish-to-html)
          ("static"
           :base-directory ,(expand-file-name "org/notes" user-emacs-directory)
           :base-extension "css\\|txt\\|jpg\\|gif\\|png"
           :recursive t
           :publishing-directory ,(expand-file-name "html" user-emacs-directory)
           :publishing-function org-publish-attachment)
          ("tinyblinker.org"
           :components ("pages" "static")))))

(provide 'org-publish-config)
;;; org-publish-config.el ends here

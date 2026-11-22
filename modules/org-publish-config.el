;;; -*- lexical-binding: t -*-
(use-package ox-publish
  :ensure nil
  :defer t
  :config
  (setq org-export-global-macros
        '(("timestamp" . "@@html:<span class=\"timestamp\">[$1]</span>@@")))
  (setq org-publish-project-alist
        `(("pages"
           :base-directory ,(expand-file-name "org" user-emacs-directory)
           :base-extension "org"
           :recursive nil
           :publishing-directory ,(expand-file-name "html/pages" user-emacs-directory)
           :publishing-function org-html-publish-to-html)
          ("blog"
           :base-directory ,(expand-file-name "org" user-emacs-directory)
           :base-extension "org"
           :recursive nil
           :publishing-directory ,(expand-file-name "html/blog" user-emacs-directory)
           :publishing-function org-html-publish-to-html
           ;; html5
           :html-doctype "html5"
           :html-html5-fancy t
           ;; disable some Org's default StyleSheet(css) & Scripts
           :html-head-include-scripts nil
           :html-head-include-default-style nil
           ;; use customed StyleSheet(css)
           :html-head "<link rel=\"stylesheet\" href=\"/style.css\" type=\"text/css\"/>"
           ;; html preamble & postamble
           :html-preamble "<nav>
<a href=\"/\">&lt; Home</a>
</nav>
<div id=\"updated\">Updated: %C</div>"
           :html-postamble "<hr/>
<footer>
  <div class=\"copyright-container\">
    <div class=\"copyright\">
      Copyright &copy; 2025-2026 Tinyblinker some rights reserved<br/>
      Content is available under
      <a rel=\"license\" href=\"https://creativecommons.org/licenses/by-sa/4.0/\">
        CC-BY-SA 4.0
      </a> unless otherwise noted
    </div>
    <div class=\"cc-badge\">
      <a rel=\"license\" href=\"https://creativecommons.org/licenses/by-sa/4.0/\">
        <img alt=\"Creative Commons License\" src=\"https://i.creativecommons.org/l/by-sa/4.0/88x31.png\" />
      </a>
    </div>
  </div>
  <div class=\"generated\">
    Created with %c on <a href=\"https://www.gnu.org\">GNU</a>/<a href=\"https://www.kernel.org\">Linux</a>
  </div>
</footer>"
           ;; Sitemap settings
           :auto-sitemap t
           :sitemap-title "Blog Posts"
           :sitemap-filename "index.org"
           :sitemap-sort-files anti-chronologically
           :sitemap-format-entry my/org-sitemap-date-entry-format)
          ("static"
           :base-directory ,(expand-file-name "org" user-emacs-directory)
           :base-extension "css\\|txt\\|jpg\\|gif\\|png"
           :recursive t
           :publishing-directory ,(expand-file-name "html/static" user-emacs-directory)
           :publishing-function org-publish-attachment)
          ("tinyblinker.org"
           :components ("pages" "blog" "static")))))

(provide 'org-publish-config)
;;; org-publish-config.el ends here

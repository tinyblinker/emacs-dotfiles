;;; -*- lexical-binding: t -*-

;; ob-mermaid: mermaid diagram support in org-babel source blocks
(use-package ob-mermaid
  :ensure t
  :after org
  :config
  (add-to-list 'org-babel-tangle-lang-exts '("mermaid" . "mmd")))

(provide 'ob-mermaid-config)
;;; ob-mermaid-config.el ends here

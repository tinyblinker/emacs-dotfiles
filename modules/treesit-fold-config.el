;;; -*- lexical-binding: t -*-

(use-package treesit-fold
  :vc (:url "https://github.com/emacs-tree-sitter/treesit-fold")
  :commands (treesit-fold-mode
             global-treesit-fold-mode
             treesit-fold-toggle
             treesit-fold-open-all
             treesit-fold-close-all)
  :custom
  (treesit-fold-line-count-show t)
  :config
  (global-treesit-fold-mode 1)
  (set-face-attribute 'treesit-fold-replacement-face nil
                      :inherit 'shadow
                      :weight 'bold))

;; global-keys
(global-set-key (kbd "C-c C-c C-g") #'treesit-fold-toggle)
(global-set-key (kbd "C-c C-c C-c") #'treesit-fold-close-all)
(global-set-key (kbd "C-c C-c C-o") #'treesit-fold-open-all)

;;; treesit-fold-config.el ends here

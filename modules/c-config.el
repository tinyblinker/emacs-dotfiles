;;; -*- lexical-binding: t -*-

;; mode-remap('c-mode' remapped to the 'c-ts-mode')
(add-to-list 'major-mode-remap-alist '(c-mode . c-ts-mode))

;; ensure Eglot load after c-ts-mode
(add-hook 'c-ts-mode-hook #'eglot-ensure)

;; Do not load c-mode(throw an user error)
(defun my/reject-c-mode ()
  (user-error "Please use 'c-ts-mode' instead of the 'c-mode'"))
(add-hook 'c-mode-hook #'my/reject-c-mode)
(with-eval-after-load 'c-mode #'my/reject-c-mode)

;; let Eglot launch 'Clangd' in c-ts-mode
(with-eval-after-load 'eglot
  (add-to-list 'eglot-server-programs
               '(c-ts-mode . ("clangd"))))

;; keymaps in 'c-ts-mode'
(with-eval-after-load 'c-ts-mode
  (keymap-set c-ts-mode-map "C-c C-f" #'eglot-format-buffer))

(provide 'c-config)
;;; c-config.el ends here

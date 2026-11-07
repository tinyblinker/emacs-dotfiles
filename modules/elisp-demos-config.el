;;; -*- lexical-binding: t -*-
(use-package elisp-demos
  :ensure t
  :config
  (advice-add 'describe-function-1 :after #'elisp-demos-advice-describe-function-1))

(provide 'elisp-demos-config)
;;; elisp-demos-config.el ends here

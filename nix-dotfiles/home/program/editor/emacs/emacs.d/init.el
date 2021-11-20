;;;  package -- my elisp configuration
;;; Commentary:
;;; load individule components

;;; Code:
(add-to-list 'load-path (concat user-emacs-directory "elisp"))

(require 'pre-init)
(require 'base)
(require 'theme)
(require 'keybind)
(require 'vim)
(require 'splash)
(require 'vcs)
(require 'completion)
(require 'lsp)

;;; init.el ends here

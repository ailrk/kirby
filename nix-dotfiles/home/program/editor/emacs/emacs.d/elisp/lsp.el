;; flycheck syntax checker


(use-package flycheck
  :init (global-flycheck-mode))

;; Disable the error indicator on the fringe
(setq flycheck-indication-mode 'left-fringe)

;; disable automatic syntax checks on new line
(setq flycheck-check-syntax-automatically '(save idle-change mode-enabled))

;; Immediate syntax checking quite annoying. Slow it down a bit.
(setq flycheck-idle-change-delay 2.0)

(with-eval-after-load 'flycheck
  (setq flycheck-disabled-checkers '(emacs-lisp-checkdoc)))

;; lsp
(use-package lsp-mode
  :init
  (setq lsp-keymap-prefix "C-c l")
  :hook ((python-mode . lsp-deferred)
         (rust-mode . lsp-deferred)
         (typescript-mode . lsp-deferred)
         (lsp-mode . lsp-enable-which-key-integration))
  :commands (lsp lsp-deferred))

(use-package lsp-ui
  :hook (lsp-mode . lsp-ui-mode)
  :custom
  (lsp-ui-doc-position 'bottom))

(use-package lsp-
ivy :commands lsp-ivy-workspace-symbol)
(use-package lsp-treemacs :commands lsp-treemacs-errors-list)

; (use-package company-lsp :commands company-lsp)

;;Optional - provides snippet support.

(use-package yasnippet
  :commands yas-minor-mode
  :hook ((python-mode . yas-minor-mode)
	 ))

(setq lsp-ui-doc-enable t
      lsp-ui-peek-enable t
      lsp-ui-sideline-enable t
      lsp-ui-imenu-enable t
      lsp-ui-flycheck-enable t)

;; DAP
(use-package dap-mode
  ;; Uncomment the config below if you want all UI panes to be hidden by default!
  ;; :custom
  ;; (lsp-enable-dap-auto-configure nil)
  ;; :config
  ;; (dap-ui-mode 1)
  :commands dap-debug
  :config
  ;; Set up Node debugging
  (require 'dap-node)
  (dap-node-setup) ;; Automatically installs Node debug adapter if needed
  (require 'dap-hydra)
  (require 'dap-gdb-lldb)
  (dap-gdb-lldb-setup)
  ; (setq dap-lldb-debug-program '("/usr/local/Cellar/llvm/11.1.0/bin/lldb-vscode")))

  ;; Bind `C-c l d` to `dap-hydra` for easy access
  (general-define-key
    :keymaps 'lsp-mode-map
    :prefix lsp-keymap-prefix
    "d" '(dap-hydra t :wk "debugger")))


;; (use-package dap-LANGUAGE) to load the dap adapter for your language

(provide 'lsp)

;;; debugger.el -*- lexical-binding: t; -*-

;;Debugger
;;

(after! dap-mode
  (setq dap-python-debugger 'debugpy)

  (dap-register-debug-template "Flask"
                               (list :type "python"
                                     :args "-i"
                                     :cwd nil
                                     :env '(
                                            ("FLASK_APP" . "wsgi.py")
                                            )
                                     :args (concat
                                            "run"
                                            "--no-debugger" ;; dap-debug had conflicts with built-in debugger
                                            "--port 45120"
                                            )
                                     :request "launch"
                                     :name "Flask")))

;; Run C programs directly from within emacs
(defun execute-c-program ()
  (interactive)
  (defvar foo)
  (setq foo (concat "gcc -lcurl " (buffer-name) " && ./a.out" ))
  (shell-command foo))

;; LSP (language server protocol) configuration
;;

(after! lsp-mode
  (add-to-list 'lsp-file-watch-ignored-directories "[/\\\\]tmp\\'")
  (add-to-list 'lsp-file-watch-ignored-directories "[/\\\\]venv\\'")
  (add-to-list 'lsp-file-watch-ignored-directories "[/\\\\]node_modules\\'"))

;; Fix debugger breakpoints view
(add-hook! +dap-running-session-mode
  (set-fringe-style (quote (20 . 10)))
  (set-window-buffer nil (current-buffer))
  )

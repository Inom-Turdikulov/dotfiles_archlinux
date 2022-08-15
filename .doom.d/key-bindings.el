;;; key-bindings.el -*- lexical-binding: t; -*-

(global-set-key (kbd "C-'")   'avy-goto-char-2)
(global-set-key (kbd "C-\"")   'avy-goto-line)
(global-set-key (kbd "C-c z") 'zeal-at-point)
(global-set-key (kbd "C-s")   'save-buffer)
(global-set-key (kbd "C-c d") 'look-up-dict-marked)
(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "C-S-p") (lambda () (interactive) (anki-editor-push-notes) (doom/reload-font)))
(global-set-key (kbd "C-<f1>") 'execute-c-program)
(global-set-key (kbd "C-<f2>") 'speed-type-buffer)
(global-set-key (kbd "C-<f3>") 'langtool-check)
(global-set-key (kbd "C-c SPC") '+workspace/switch-to)
(global-set-key (kbd "C-S-<f3>") 'langtool-check-done)
(global-set-key (kbd "C-<f4>") (lambda() (interactive) (magit-status "/yadm::")))


(use-package! elfeed
  :general
  (:keymaps '(elfeed-show-mode-map elfeed-search-mode-map)
   "C-c C-c" 'elfeed-visit-or-play-with-mpv
   ))

;; Leader key-maps

(map! :leader
      :desc "emms"
      "o e" (lambda() (interactive) (persp-switch "*EMMS*")))

(map! :leader
      :desc "Org attach screenshot"
      "N a" #'org-attach-screenshot)

(map! :leader
      :desc "irc"
      "o i t" (lambda() (interactive) (setq frame-title-format "%b - Bitlbee"))
      "o i i" #'=irc)

(map! :leader
      :desc "News (rss) client"
      "o n" #'=rss)

(map! :map dap-mode-map
      :leader
      :prefix ("d" . "dap")
      ;; basics
      :desc "dap next"          "n" #'dap-next
      :desc "dap step in"       "i" #'dap-step-in
      :desc "dap step out"      "o" #'dap-step-out
      :desc "dap continue"      "c" #'dap-continue
      :desc "dap hydra"         "h" #'dap-hydra
      :desc "dap debug restart" "r" #'dap-debug-restart
      :desc "dap debug"         "s" #'dap-debug

      ;; debug
      :prefix ("dd" . "Debug")
      :desc "dap debug recent"  "r" #'dap-debug-recent
      :desc "dap debug last"    "l" #'dap-debug-last

      ;; eval
      :prefix ("de" . "Eval")
      :desc "eval"                "e" #'dap-eval
      :desc "eval region"         "r" #'dap-eval-region
      :desc "eval thing at point" "s" #'dap-eval-thing-at-point
      :desc "add expression"      "a" #'dap-ui-expressions-add
      :desc "remove expression"   "d" #'dap-ui-expressions-remove

      :prefix ("db" . "Breakpoint")
      :desc "dap breakpoint toggle"      "b" #'dap-breakpoint-toggle
      :desc "dap breakpoint condition"   "c" #'dap-breakpoint-condition
      :desc "dap breakpoint hit count"   "h" #'dap-breakpoint-hit-condition
      :desc "dap breakpoint log message" "l" #'dap-breakpoint-log-message)

(use-package! lexic
  :commands lexic-search lexic-list-dictionary
  :config
  (map! :map lexic-mode-map
        :n "q" #'lexic-return-from-lexic
        :nv "RET" #'lexic-search-word-at-point
        :n "a" #'outline-show-all
        :n "h" (cmd! (outline-hide-sublevels 3))
        :n "o" #'lexic-toggle-entry
        :n "n" #'lexic-next-entry
        :n "N" (cmd! (lexic-next-entry t))
        :n "p" #'lexic-previous-entry
        :n "P" (cmd! (lexic-previous-entry t))
        :n "E" (cmd! (lexic-return-from-lexic) ; expand
                     (switch-to-buffer (lexic-get-buffer)))
        :n "M" (cmd! (lexic-return-from-lexic) ; minimise
                     (lexic-goto-lexic))
        :n "C-p" #'lexic-search-history-backwards
        :n "C-n" #'lexic-search-history-forwards
        :n "/" (cmd! (call-interactively #'lexic-search))))

;;; app.el -*- lexical-binding: t; -*-
;; Circe configuration
(after! circe
(enable-circe-display-images))

;; Ebooks configuration
;;

;; Epub books
(use-package! nov
  :mode ("\\.epub\\'" . nov-mode)
  :config
  (setq nov-save-place-file (concat doom-cache-dir "nov-places")))

;; FB2 books
(use-package! fb2-reader
  :commands (fb2-reader-continue)
  :custom
  ;; This mode renders book with fixed width, adjust to your preferences.
  (fb2-reader-page-width 80)
  (fb2-reader-image-max-width 400)
  (fb2-reader-image-max-height 400))

;; Notmuch configuration
;;

;; Fix notmuch background colors
(setq shr-use-colors nil
      shr-use-fonts nil)

(setq +notmuch-sync-backend 'mbsync)
(setq +notmuch-home-function (lambda () (notmuch-search "tag:inbox")))

;; use current one window - bugfix
(after! notmuch
  (set-popup-rule! "^\\*notmuch-hello" :ignore t))

;; restore modeline in notmuch-search-mode
(use-package! notmuch
  :defer t
  :config

  ;; modeline doesn't have much use in these modes
  (remove-hook! '(notmuch-show-mode-hook
               notmuch-tree-mode-hook
               notmuch-search-mode-hook)
             #'hide-mode-line-mode)
  )

(setq sendmail-program "/usr/bin/msmtp")
(setq send-mail-function 'message-send-mail-with-sendmail)

;; Persp config
(after! persp-mode
  (persp-def-buffer-save/load
   :mode 'notmuch-search-mode
   :mode-restore-function #'(lambda (_mode) (=notmuch)) ; or #'identity if you do not want to start shell process
   :tag-symbol 'def-email
   :save-vars '(major-mode default-directory))

  ;; Persp-mode and Special Buffers
  (persp-def-buffer-save/load
   :mode 'vterm-mode :tag-symbol 'def-vterm-buffer
   :save-vars '(major-mode default-directory))
)

;; Leetcode
;; leetcode-show-problem-by-slug will let you put to org files with a link
(use-package! leetcode
  :config
  (setq leetcode-prefer-language "python3")
  (setq leetcode-prefer-sql "mysql")
  (setq leetcode-save-solutions t)
  (setq leetcode-directory "~/org/leetcode/")
  )

;; Evil specifc
(use-package! evil
  :config
  (fset 'evil-visual-update-x-selection 'ignore) ;; stop copy visual selection
  )




(defadvice! +lookup/dictionary-definition-lexic (identifier &optional arg)
  "Look up the definition of the word at point (or selection) using `lexic-search'."
  :override #'+lookup/dictionary-definition
  (interactive
   (list (or (doom-thing-at-point-or-region 'word)
             (read-string "Look up in dictionary: "))
         current-prefix-arg))
  (lexic-search identifier nil nil t))

(use-package! evil-lion
  :config
  (evil-lion-mode))


;; Vterm func
(after! vterm
(add-to-list 'vterm-eval-cmds '("update-pwd" (lambda (path) (setq default-directory path))))
(push (list "find-file-below"
            (lambda (path)
              (if-let* ((buf (find-file-noselect path))
                        (window (display-buffer-below-selected buf nil)))
                  (select-window window)
                (message "Failed to open file: %s" path))))
      vterm-eval-cmds))


;; csv
(add-hook 'csv-mode-hook (lambda () (setq truncate-lines t)))

;; (use-package! dirvish
;;   :config
;;   (dirvish-override-dired-mode))

(with-eval-after-load "ispell"
  (setenv "LANG" "en_US.UTF-8")
  (setq! ispell-program-name "hunspell")
  (setq! ispell-dictionary "en_US,ru_RU")
  (ispell-set-spellchecker-params)
  (ispell-hunspell-add-multi-dic "en_US,ru_RU")
  )

;; Screenshot directory
(use-package! org-attach-screenshot
  :config
  (setq org-attach-screenshot-relative-links t)
  (setq org-attach-screenshot-dirfunction
  (lambda ()
    (progn (cl-assert (buffer-file-name))
    (concat (file-name-sans-extension (buffer-file-name))
     "-att")))
  org-attach-screenshot-command-line "maim -s %f"))

;;; org.el -*- lexical-binding: t; -*-

;; ORG configuration
;;

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(after! org
(setq
 org-directory "~/org/"
 org-default-notes-file "~/org/inbox.org" ;; default file for notes
 org-agenda-files '("~/org/" "~/org/roam")
 org-roam-directory (file-truename "~/org/roam")
 org-roam-dailies-directory "../daily/"
 org-log-into-drawer t                           ; Logging goesinto the LOGBOOK drawer
 org-log-done 'time                              ; automatic logging is to keep track of when a certain TODO item was marked as done
 org-log-reschedule (quote time)                 ; information to record when the scheduling date of a task is modified.
 org-refile-allow-creating-parent-nodes 'confirm ; allow the creation of new nodes as refile targets.
 org-deadline-warning-days 7                     ; deadline becomes active in 7 days

 )

 (add-to-list 'org-modules 'org-habit t)

 ;; Automatically toggle Org mode LaTeX fragment previews as the cursor enters and exits them
 (add-hook 'org-mode-hook 'org-fragtog-mode)

 ;; disable line numbers in org-mode
 (add-hook 'org-mode-hook (lambda () (display-line-numbers-mode -1)))
)

;; Insert krita app images into org files
(use-package! org-krita
  :config
  (add-hook 'org-mode-hook 'org-krita-mode))

(setq org-roam-capture-templates
     ; file-name should not include the extension
      (list

       '("c" "contact" plain "%?"
         :target (file+head "../contacts/%<%Y%m%d%H%M%S>-${title}.org"
                            "#+title: ${title}
#+filetags: contact

* PERSON ${title}
:PROPERTIES:
:ADDRESS: %^{Russia}
:BIRTHDAY: %^{yyyy-mm-dd}
:EMAIL: %^{EMAIL}
:PHONE: %^{+7}
:NOTE: %^{NOTE}
:END:"
                            )
         :unnarrowed t)
       '("r" "bibliography reference" plain
         (file "templates/orb-template.org") ; <-- template store in a separate file
         :target
         (file+head   "${citekey}.org" ":PROPERTIES:
:ROAM_REFS: cite:${citekey}
:END:
#+title: ${title}
#+filetags: ${tags}\n
#+date: %t\n")
         :empty-lines 1
         :unnarrowed t)
       '("d" "default" plain "%?"
         :target (file+head "%<%Y%m%d%H%M%S>-${slug}.org"
                            "#+title: ${title}\n#+date: %t\n")
         :unnarrowed t)
       '("p" "private" plain "%?"
         :target (file+head "private/${slug}.org.gpg"
                            "#+title: ${title}\n")
         :unnarrowed t)
       ))

;; Configure orb (org-roam-bibtex)
(setq orb-preformat-keywords
      '("citekey" "title" "url" "author-or-editor" "keywords" "file" "tags")
      orb-process-file-keyword t
      orb-attached-file-extensions '("pdf" "docx" "doc" "epub"))

;; Configure org-noter (plain notes for books)
;;

(after! org-noter
  (setq org-noter-notes-search-path '(expand-file-name "~/org/roam/")
        org-noter-notes-window-location 'horizontal-split
        ))

;; Org-ref configuration

(setq! bibtex-completion-bibliography '("~/Documents/library.bib"))
(setq! citar-bibliography '("~/Documents/library.bib"))

(setq! bibtex-completion-notes-path "~/org/roam/")
(setq! citar-notes-paths '("~/org/roam/"))

;; citar-library-paths '("/path/to/library/files/") ;; pdf's files
;; bibtex-completion-library-path '("/path/to/library/path/") ;; pdf's files

;; (use-package! org-ref
;;     ;:after org-roam
;;     :config
;;     (setq
;;          org-ref-note-title-format "* %y - %t\n :PROPERTIES:\n  :Custom_ID: %k\n  :NOTER_DOCUMENT: %F\n :ROAM_KEY: cite:%k\n  :AUTHOR: %9a\n  :JOURNAL: %j\n  :YEAR: %y\n  :VOLUME: %v\n  :PAGES: %p\n  :DOI: %D\n  :URL: %U\n :END:\n\n"
;;          org-ref-notes-directory (file-truename "~/org/roam")
;;          org-ref-notes-function 'orb-edit-notes
;;     ))

(after! org-ref
(setq
 bibtex-completion-pdf-field "file"
 bibtex-completion-notes-template-multiple-files
 (concat
  "#+TITLE: ${title}\n"
  "#+ROAM_KEY: cite:${=key=}\n"
  "* TODO Notes\n"
  ":PROPERTIES:\n"
  ":Custom_ID: ${=key=}\n"
  ":NOTER_DOCUMENT: %(orb-process-file-field \"${=key=}\")\n"
  ":AUTHOR: ${author-abbrev}\n"
  ":JOURNAL: ${journaltitle}\n"
  ":DATE: ${date}\n"
  ":YEAR: ${year}\n"
  ":DOI: ${doi}\n"
  ":URL: ${url}\n"
  ":END:\n\n"
  )
 )
)

;; Org-pomodoro configuration
;;

(setq org-pomodoro-length 25)
(setq org-pomodoro-manual-break t)

(defun ruborcalor/org-pomodoro-time ()
"Return the remaining pomodoro time"

(if (fboundp 'org-pomodoro-active-p)
    (if (org-pomodoro-active-p)
(cl-case org-pomodoro-state

(:pomodoro
(format "%d minutes - %s" (/ (org-pomodoro-remaining-seconds) 60) org-clock-heading))

(:short-break
(format "Short break time: %d minutes" (/ (org-pomodoro-remaining-seconds) 60)))

(:long-break
(format "Long break time: %d minutes" (/ (org-pomodoro-remaining-seconds) 60)))

(:overtime
(format "Overtime! %d minutes" (/ (org-pomodoro-remaining-seconds) 60))))

"idle")))

;; Evil - TAB was changed to toggle only the visibility state of the current
;; subtree, rather than cycle through it recursively. This can be reversed with:
(after! evil-org
  (define-key org-mode-map (kbd "C-'") 'avy-goto-char-2)
  (remove-hook 'org-tab-first-hook #'+org-cycle-only-current-subtree-h))

;; TO-DO toggle custom priority
(after! org
 (setq org-todo-keywords
        '((sequence
           "LOOP(r)"  ; A recurring task
           "TODO(t)"  ; A task that needs doing & is ready to do
           "NEXT(n)"  ; A task that needs doing & is ready to do
           "PROJ(p)"  ; A project, which usually contains other tasks
           "STRT(s)"  ; A task that is in progress
           "WAIT(w)"  ; Something external is holding up this task
           "HOLD(h)"  ; This task is paused/on hold because of me
           "IDEA(i)"  ; An unconfirmed and unapproved task or notion
           "|"
           "DONE(d)"  ; Task successfully completed
           "KILL(k)") ; Task was cancelled, aborted or is no longer applicable
          (sequence
           "[ ](T)"   ; A task that needs doing
           "[-](S)"   ; Task is in progress
           "[?](W)"   ; Task is being held up or paused
           "|"
           "[X](D)")  ; Task was completed
          (sequence
           "|"
           "OKAY(o)"
           "YES(y)"
           "NO(n)"))
        org-todo-keyword-faces
        '(("[-]"  . +org-todo-active)
          ("STRT" . +org-todo-active)
          ("[?]"  . +org-todo-onhold)
          ("WAIT" . +org-todo-onhold)
          ("HOLD" . +org-todo-onhold)
          ("PROJ" . +org-todo-project)
          ("NO"   . +org-todo-cancel)
          ("KILL" . +org-todo-cancel)))
 )


;; Append addtional languages
(org-babel-do-load-languages 'org-babel-load-languages
                             (append org-babel-load-languages
                              '((spice     . t))))


(defun markdown-convert-buffer-to-org ()
    "Convert the current buffer's content from markdown to orgmode format and save it with the current buffer's file name but with .org extension."
    (interactive)
    (shell-command-on-region (point-min) (point-max)
                             (format "pandoc -f markdown -t org -o %s"
                                     (concat (file-name-sans-extension (buffer-file-name)) ".org"))))

;; Configure pdf-tools
(use-package! pdf-tools
  :config
  (pdf-tools-install)
  ;; This means that pdfs are fitted to width by default when you open them
  (setq-default pdf-view-display-size 'fit-width)
  :custom
  (pdf-annot-activate-created-annotations t "automatically annotate highlights"))

;; Org image size config
;; We try to get the width of the image, and when it is bigger than the current
;; window we use the actual window size in the preview. When it is smaller than
;; the window, we use the actual size. And if you use attr_org to set the image
;; size, we use that instead. We use an :around advice to basically replace the
;; built in call to org--create-inline-image call. It is only lightly tested
;; with file links.
(defun get-image-width (fname)
  "Returns the min of image width and window width, unless :width
is defined in an attr_org line."
  (let* ((link (save-match-data (org-element-context)))
     (paragraph (let ((e link))
              (while (and (setq e (org-element-property
                       :parent e))
                  (not (eq (org-element-type e)
                       'paragraph))))
              e))
     (attr_org (org-element-property :attr_org paragraph))
     (pwidth (plist-get
          (org-export-read-attribute :attr_org  paragraph) :width))
     (width (when pwidth (string-to-number pwidth)))
     open
     img-buf)

    (unless width
      (setq open (find-buffer-visiting fname)
        img-buf (or open (find-file-noselect fname))
        width (min (window-width nil :pixels)
               (car (image-size (with-current-buffer img-buf (image-get-display-property)) :pixels))))

      (unless open (kill-buffer img-buf)))
    width))

(defun around-image-display (orig-fun file width)
  (apply orig-fun (list file (get-image-width file))))

(advice-add 'org--create-inline-image :around #'around-image-display)
(setq org-format-latex-options (plist-put org-format-latex-options :scale 3))

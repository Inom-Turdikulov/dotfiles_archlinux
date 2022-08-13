;;; elfeed.el -*- lexical-binding: t; -*-

;; Run elfeed update
(use-package! elfeed
  :config
  (evil-define-key 'normal elfeed-show-mode-map (kbd "U") 'elfeed-show-tag--unread)

  (defun hrs/custom-elfeed-sort (a b)
    (let* ((a-tags (format "%s" (elfeed-entry-tags a)))
           (b-tags (format "%s" (elfeed-entry-tags b)))
           (a-title (elfeed-feed-title (elfeed-entry-feed a)))
           (b-title (elfeed-feed-title (elfeed-entry-feed b))))
      (if (string= a-tags b-tags)
          (if (string= a-title b-title)
              (< (elfeed-entry-date b) (elfeed-entry-date a))
            (string< b-title a-title))
        (string< a-tags b-tags))))
  (setf elfeed-search-sort-function #'hrs/custom-elfeed-sort)

  (elfeed-set-max-connections 32)

  (global-set-key (kbd "C-c r") 'elfeed))

(defun elfeed-play-with-mpv ()
  "Play entry link with mpv."
  (interactive)
  (let ((entry (if (eq major-mode 'elfeed-show-mode) elfeed-show-entry (elfeed-search-selected :single))))
    (start-process "elfeed-mpv" nil "linkhandler" (elfeed-entry-link entry))))

(defvar elfeed-mpv-patterns
  '("twit\\.?ch" "youtu\\.?be")
  "List of regexp to match against elfeed entry link to know
whether to use mpv to visit the link.")

(defun elfeed-visit-or-play-with-mpv ()
  "Play in mpv if entry link matches `elfeed-mpv-patterns', visit otherwise.
See `elfeed-play-with-mpv'."
  (interactive)
  (let ((entry (if (eq major-mode 'elfeed-show-mode) elfeed-show-entry (elfeed-search-selected :single)))
        (patterns elfeed-mpv-patterns))
    (while (and patterns (not (string-match (car patterns) (elfeed-entry-link entry))))
      (setq patterns (cdr patterns)))
    (if patterns
        (elfeed-play-with-mpv)
      (if (eq major-mode 'elfeed-search-mode)
          (elfeed-search-browse-url)
        (elfeed-show-visit)))))

(use-package! elfeed
  :bind (:map elfeed-search-mode-map
              ("B" . elfeed-visit-or-play-with-mpv))
  :config
  (defun ar/elfeed-search-browse-background-url ()
    "Open current `elfeed' entry (or region entries) in browser without losing focus."
    (interactive)
    (let ((entries (elfeed-search-selected)))
      (mapc (lambda (entry)
              (cl-assert (memq system-type '(darwin)) t "open command is macOS only")
              (start-process (concat "open " (elfeed-entry-link entry))
                             nil "open" "--background" (elfeed-entry-link entry))
              (elfeed-untag entry 'unread)
              (elfeed-search-update-entry entry))
            entries)
      (unless (or elfeed-search-remain-on-entry (use-region-p))
        (forward-line)))))

(use-package! elfeed-tube
  :after elfeed
  :demand t
  :config
  (elfeed-tube-setup))

(add-hook! 'elfeed-search-mode-hook #'elfeed-update)

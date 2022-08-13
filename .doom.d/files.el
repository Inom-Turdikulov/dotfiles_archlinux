;;; files.el -*- lexical-binding: t; -*-

;; ;; This will save all unsaved buffers visiting file
;; (add-to-list 'focus-out-hook (lambda () (save-some-buffers t nil)))

;; Automatically reload files was modified by external program
(global-auto-revert-mode t)

;; Configure mimeopen -d to setup associations
;;

(use-package! openwith
  :after-call pre-command-hook
  :config
  (openwith-mode t)
  (setq openwith-associations '(("\\.gif\\'" "xdg-open" (file))
                              ("\\.avi\\'" "xdg-open" (file))
                              ("\\.mkv\\'" "xdg-open" (file))
                              ("\\.mp3\\'" "xdg-open" (file))
                              ("\\.mp3u\\'" "xdg-open" (file))
                              ("\\.mp4\\'" "xdg-open" (file))
                              ("\\.webm\\'" "xdg-open" (file))
                              ("\\.cbr\\'" "YACReader" (file))
                              )))

;; copy the file-name/full-path in dired buffer into clipboard
;; `w` => copy file name
;; `C-u 0 w` => copy full path
(defadvice dired-copy-filename-as-kill (after dired-filename-to-clipboard activate)
  (with-temp-buffer
    (insert (current-kill 0))
    (shell-command-on-region (point-min) (point-max)
                             (cond
                              ((eq system-type 'cygwin) "putclip")
                              ((eq system-type 'darwin) "pbcopy")
                              (t "xsel -ib")
                              )))
  (message "%s => clipboard" (current-kill 0)))


;; Open dired directory in sxiv (image viewer)
(defun dired-open-directory-in-sxiv ()
  "Copy the current buffer file name to the clipboard."
  (interactive)
  (let ((filename (if (equal major-mode 'dired-mode)
                      default-directory
                    (buffer-file-name))))
    (when filename
          (kill-new filename)
          (message "Copied buffer file name '%s' to the clipboard." filename)
          (shell-command-to-string (format "sxiv -t %s*" filename))
          )))

;; Yadm tramp config
(add-to-list 'tramp-methods
             '("yadm"
               (tramp-login-program "yadm")
               (tramp-login-args (("enter")))
               (tramp-login-env (("SHELL") ("/bin/sh")))
               (tramp-remote-shell "/bin/sh")
               (tramp-remote-shell-args ("-c"))))

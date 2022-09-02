;;; style.el -*- lexical-binding: t; -*-

(menu-bar-mode -1)
(tool-bar-mode -1)
(toggle-scroll-bar -1)
(setq frame-title-format "GNU Emacs | %b")
(setq scroll-margin 2 ) ; It's nice to maintain a little margin
(setq all-the-icons-scale-factor 1) ;; height face property of an icon

;; Fonts configuration
;;

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
(setq doom-font (font-spec :family "monospace" :size 38 :weight 'regular)
      doom-variable-pitch-font (font-spec :family "monospace" :size 38))

(setq doom-unicode-font (font-spec :family "Noto Color Emoji" :size 38))

(add-hook! 'after-setting-font-hook :append
  (set-fontset-font t 'unicode (font-spec :family "monospace" :size 38) nil 'prepend))

;; Set theme
(setq doom-theme 'doom-one)
(setq doom-themes-treemacs-theme "doom-colors")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; Line-number gutter width
(setq display-line-numbers-width nil)

;; Whether display the workspace name. Non-nil to display in the mode-line.
(after! doom-modeline
  ;; Custom modeline items order
  (doom-modeline-def-modeline 'main
    '(persp-name bar workspace-name window-number modals matches buffer-info remote-host buffer-position word-count parrot selection-info)
    '(objed-state misc-info battery irc mu4e gnus github debug lsp minor-modes input-method indent-info buffer-encoding major-mode process vcs checker))

  ;; Show workspace name
  (setq doom-modeline-persp-name t)

  ;; Show wordcount in selection
  (setq doom-modeline-enable-word-count t)

  (custom-set-faces
    '(mode-line ((t (:family "monospace" :height 1.0))))
    '(mode-line-inactive ((t (:family "monospace" :height 1.0)))))
    (advice-add #'doom-modeline--font-height :override #'(lambda () (progn 1.0)))

  ;; Whether display the IRC notifications. It requires `circe' or `erc' package.
  (setq doom-modeline-irc nil)
)

;; Alert style
(use-package! alert
  :commands (alert)
  :init
  (setq alert-default-style 'notifier))

;; Highlights delimiters such as parentheses, brackets or braces according to their depth.
(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)

;; Show vertical column indicator (80 lines line)
(add-hook 'prog-mode-hook #'display-fill-column-indicator-mode)

;; support cursor shape in terminal
(use-package! evil-terminal-cursor-changer
  :hook (tty-setup . evil-terminal-cursor-changer-activate))

;; Transparent background in tty
(defun set-background-for-terminal (&optional frame)
  (or frame (setq frame (selected-frame)))
  "unsets the background color in terminal mode"
  (unless (display-graphic-p frame)
    (set-face-background 'default "unspecified-bg" frame)))
(add-hook 'after-make-frame-functions 'set-background-for-terminal)
(add-hook 'window-setup-hook 'set-background-for-terminal)


;; enable word-wrap in org-mode, csv-mode
(add-hook 'org-mode-hook (lambda ()
                             ;; make the lines in the buffer wrap around the edges of the screen.
                             ;; to press C-c q  or fill-paragraph ever again!
                             (auto-fill-mode)))

;; vterm on right side
(set-popup-rules!
 '(("^\\*doom:vterm" :size 0.4 :vslot -4 :select t :quit nil :ttl 0 :side right)
 ))

;; background transparency
(setq default-frame-alist '((alpha-background . 95)))

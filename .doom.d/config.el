;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!

;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;; Basic configuration
(setq undo-limit 80000000                              ; Raise undo-limit to 80Mb
      evil-want-fine-undo t                            ; By default while in insert all changes are one big blob. Be more granular
      x-select-enable-clipboard t                      ; Use system clipboard
      auto-save-default t                              ; Nobody likes to loose work, I certainly don't
      password-cache-expiry nil                        ; I can trust my computers ... can't I?
      delete-by-moving-to-trash t                      ; Delete files to trash
      company-idle-delay 0.6                           ; Autocomplete delay timer
      tramp-default-method "ssh"                       ; Default method for tramp
      tramp-use-ssh-controlmaster-options nil          ; Use the customisations in your ~/.ssh/config
      projectile-project-search-path '("~/Projects/")  ; Main projects directory
      )

;; Personal configuraton, like name, email, etc
(if (file-exists-p (file-name-concat doom-private-dir "personal.el"))
    (load! "personal"       doom-private-dir))

(load! "style"          doom-private-dir) ;; Emacs visual styles
(load! "org"            doom-private-dir) ;; org-mode
(load! "voice-recorder" doom-private-dir) ;; voice recorder functions
(load! "files"          doom-private-dir) ;; File Processing System
(load! "app"            doom-private-dir) ;; app specific config, like email, feeds, etc
(load! "elfeed"         doom-private-dir) ;; elfeed rss config
(load! "debugger"       doom-private-dir) ;; dap-debug and specific configurations
(load! "lang"           doom-private-dir) ;; flyspell and programming languages specific configurations
(load! "key-bindings"   doom-private-dir) ;; global and custom keybindings
(load! "input"          doom-private-dir) ;; Quickly switch input method

;; Fix issue with commiting from terminal and $EDITOR
(after! persp-mode
  (setq persp-emacsclient-init-frame-behaviour-override "main"))

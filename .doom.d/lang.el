;;; lang.el -*- lexical-binding: t; -*-

;; Autoformat on save -
(setq +format-on-save-enabled-modes
      '(not emacs-lisp-mode  ; elisp's mechanisms are good enough
            +javascript-npm-mode
            javascript-mode
            sql-mode         ; sqlformat is currently broken
            tex-mode         ; latexindent is broken
            web-mode
            latex-mode))

(add-hook 'flyspell-mode-hook 'flyspell-buffer)
(add-hook 'text-mode-hook (lambda ()
                                 (when (not (equal major-mode 'org-mode))
                                   (flyspell-mode t))))

;; set indentation to a more conventional value
(setq opascal-indent-level 2)
(setq opascal-case-label-indent 2)

;; Syntax highlight
(use-package! tree-sitter
  :config

 ;; Don't highlight strings, in any language.
 (add-function :before-while tree-sitter-hl-face-mapping-function
   (lambda (capture-name)
     (not (string= capture-name "string"))))

  (require 'tree-sitter-langs)
  (global-tree-sitter-mode)
  (add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode))

;; Input configuration
(use-package! reverse-im
  :demand t ; always load it
  :after char-fold ; but only after `char-fold' is loaded
  :bind
  ("M-T" . reverse-im-translate-word) ; fix a word in wrong layout
  :custom
  (reverse-im-char-fold t) ; use lax matching
  (reverse-im-read-char-advice-function #'reverse-im-read-char-include)
  (reverse-im-input-methods '("russian-computer")) ; translate these methods
  :config
  (reverse-im-mode t)) ; turn the mode on

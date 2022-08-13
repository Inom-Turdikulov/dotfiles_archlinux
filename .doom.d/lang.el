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
  (require 'tree-sitter-langs)
  (global-tree-sitter-mode)
  (add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode))

;;; lang.el -*- lexical-binding: t; -*-

(add-hook 'flyspell-mode-hook 'flyspell-buffer)
(add-hook 'text-mode-hook (lambda ()
                                 (when (not (equal major-mode 'org-mode))
                                   (flyspell-mode t))))

;; set indentation to a more conventional value
(setq opascal-indent-level 2)
(setq opascal-case-label-indent 2)

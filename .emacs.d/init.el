;; -*- lexical-binding: t; -*-

;;; Code:
(setq package-enable-at-startup nil)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
(add-to-list 'package-archives '("org" . "https://orgmode.org/elpa/") t)
(package-initialize)
(require 'package)

;; Load config.org - my Emacs config
(org-babel-load-file (expand-file-name "~/.emacs.d/config.org"))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("603a831e0f2e466480cdc633ba37a0b1ae3c3e9a4e90183833bc4def3421a961" default))
 '(package-selected-packages
   '(puni doom-themes racket-mode undo-tree web-mode slime diff-hl highlight-indent-guides fix-word no-littering fzf magit yasnippet bind-key diminish s popwin dash which-key smart-mode-line-powerline-theme exec-path-from-shell smart-mode-line multiple-cursors browse-kill-ring rainbow-delimiters auctex-latexmk auctex)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(require 'server)
(unless (server-running-p) (server-start)) ; start emacs in server mode so that skim can talk to it

;; This should always be at the end!
;; Here we set cmd to meta, leaving alt available for alternative characters.
;; (setq mac-option-key-is-meta nil)
;; (setq mac-command-key-is-meta t)
(setq mac-command-modifier 'meta)
(setq mac-option-modifier nil)
(setq mac-right-option-modifier 'left)
(setq mac-wheel-button-is-mouse-2 nil)
;; Set fn to hyper
;; (setq ns-function-modifier 'hyper)
;; Also, don't pass uses of command to the system
(setq mac-pass-command-to-system nil)

;;; init.el ends here

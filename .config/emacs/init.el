;; -*- lexical-binding: t; -*-

;;; Code:
(require 'package)
(package-initialize)
(setq package-enable-at-startup nil) ;; don't make installed packages available before loading the init.el file.
(setq use-package-always-ensure t)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
(add-to-list 'package-archives '("org" . "https://orgmode.org/elpa/") t)


;; Load config.org - my Emacs config
(org-babel-load-file (expand-file-name "~/.config/emacs/config.org"))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("603a831e0f2e466480cdc633ba37a0b1ae3c3e9a4e90183833bc4def3421a961" default))
 '(package-selected-packages
   '(tempel lua-mode puni doom-themes racket-mode undo-tree web-mode slime diff-hl highlight-indent-guides fix-word no-littering fzf magit yasnippet bind-key diminish s popwin dash which-key smart-mode-line-powerline-theme exec-path-from-shell smart-mode-line multiple-cursors browse-kill-ring rainbow-delimiters auctex-latexmk auctex)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(require 'server)
(unless (server-running-p) (server-start)) ; start emacs in server mode so skim can talk to it

;;; init.el ends here

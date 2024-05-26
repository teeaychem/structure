;; -*- lexical-binding: t; -*-

;;; Code:
(require 'package)
(package-initialize)
(setq package-enable-at-startup nil) ;; don't make installed packages available before loading the init.el file.
(setq use-package-always-ensure t)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
(add-to-list 'package-archives '("org" . "https://orgmode.org/elpa/") t)

;; save custom things to separate file
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load custom-file))


;; Load config.org - my Emacs config
(org-babel-load-file (expand-file-name "config.org" user-emacs-directory))

(require 'server)
(unless (server-running-p) (server-start)) ; start emacs in server mode so skim can talk to it

;;; init.el ends here

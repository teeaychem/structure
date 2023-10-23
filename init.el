;; -*- lexical-binding: t; -*-

;;; Code:
(setq package-enable-at-startup nil)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
(add-to-list 'package-archives '("org" . "https://orgmode.org/elpa/") t)
(package-initialize)
(require 'package)

;; Keeping ~/emacs.d clean
(require 'no-littering)
(setq auto-save-file-name-transforms
      `((".*" ,(no-littering-expand-var-file-name "auto-save/") t)))

;; For exec-path-from-shell https://github.com/purcell/exec-path-from-shell
(when (memq window-system '(mac ns)) (exec-path-from-shell-initialize))

;; Load config.org - my Emacs config
(org-babel-load-file (expand-file-name "~/.emacs.d/config.org"))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(LaTeX-amsmath-label "eq:")
 '(TeX-command-list
   '(("LatexMk" "latexmk %(-PDF)%S%(mode) %(file-line-error) %(extraopts) %t" TeX-run-latexmk nil
      (plain-tex-mode latex-mode)
      :help "Run LatexMk")
     ("LaTeX" "%`%l%(mode)%' %T" TeX-run-TeX nil
      (latex-mode doctex-mode)
      :help "Run LaTeX")
     ("BibTeX" "bibtex %(O?aux)" TeX-run-BibTeX nil
      (plain-tex-mode latex-mode doctex-mode context-mode texinfo-mode ams-tex-mode)
      :help "Run BibTeX")
     ("Biber" "biber %(output-dir) %s" TeX-run-Biber nil
      (plain-tex-mode latex-mode doctex-mode texinfo-mode ams-tex-mode)
      :help "Run Biber")
     ("View" "%V" TeX-run-discard-or-function t t :help "Run Viewer")
     ("Check" "lacheck %s" TeX-run-compile nil
      (latex-mode)
      :help "Check LaTeX file for correctness")
     ("ChkTeX" "chktex -v6 %s" TeX-run-compile nil
      (latex-mode)
      :help "Check LaTeX file for common mistakes")
     ("Clean" "TeX-clean" TeX-run-function nil t :help "Delete generated intermediate files")
     ("Clean All" "(TeX-clean t)" TeX-run-function nil t :help "Delete generated intermediate and output files")
     ("Other" "" TeX-run-command t t :help "Run an arbitrary command")))
 '(TeX-electric-escape nil)
 '(TeX-source-correlate-mode t)
 '(custom-safe-themes
   '("88cb0f9c0c11dbb4c26a628d35eb9239d1cf580cfd28e332e654e7f58b4e721b" default))
 '(flycheck-checker-error-threshold 99400)
 '(font-latex-fontify-script nil)
 '(mac-command-modifier 'super)
 '(mac-right-option-modifier 'left)
 '(mac-wheel-button-is-mouse-2 nil)
 '(org-fontify-done-headline t)
 '(org-fontify-quote-and-verse-blocks t)
 '(org-fontify-whole-heading-line t)
 '(org-list-allow-alphabetical t)
 '(org-preview-latex-imaqge-directory "~/OrgTemp/")
 '(package-selected-packages
   '(inkpot-theme modus-themes racket-mode undo-tree web-mode dracula-theme smartparens slime diff-hl highlight-indent-guides fix-word no-littering fzf elpy magit yasnippet bind-key diminish s popwin popup epl pkg-info math-symbol-lists async dash company which-key smart-mode-line-powerline-theme use-package exec-path-from-shell smart-mode-line multiple-cursors browse-kill-ring rainbow-delimiters company-math flycheck company-auctex auctex-latexmk auctex))
 '(undo-tree-history-directory-alist
   '(("" . "/Users/sparkes/Library/CloudStorage/Dropbox/Symlink/.emacs.d/undoTree"))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(font-latex-math-face ((t (:foreground "pale violet red"))))
 '(font-latex-subscript-face ((t nil)))
 '(font-latex-superscript-face ((t nil)))
 '(hl-line ((t (:background "#F6FECD" :underline nil)))))

(require 'server)
(unless (server-running-p) (server-start)) ; start emacs in server mode so that skim can talk to it

;; This should always be at the end!
;; Here we set cmd to meta, leaving alt available for alternative characters.
;; (setq mac-option-key-is-meta nil)
;; (setq mac-command-key-is-meta t)
(setq mac-command-modifier 'meta)
(setq mac-option-modifier nil)
;; Set fn to hyper
;; (setq ns-function-modifier 'hyper)
;; Also, don't pass uses of command to the system
(setq mac-pass-command-to-system nil)

;;; init.el ends here

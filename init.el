;; magic. . .

;; Increase gc to 500MB for easy startup
(setq gc-cons-threshold (* 500 1024 1024))

(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/") t)
;; (setq package-archive-enable-alist '(("melpa" deft magit)))
(package-initialize)

;; Bootstrap `use-package'
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package)
  (package-install 'org))

;; Keeping ~/emacs.d clean
(require 'no-littering)
(setq auto-save-file-name-transforms
      `((".*" ,(no-littering-expand-var-file-name "auto-save/") t)))

;; For exec-path-from-shell
(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))

;; Load config.org - my Emacs config
(org-babel-load-file (expand-file-name "~/.emacs.d/config.org"))


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(LaTeX-math-abbrev-prefix "§")
 '(TeX-source-correlate-method (quote ((dvi . source-specials) (pdf . synctex))))
 '(TeX-source-correlate-mode t)
 '(ansi-color-names-vector
   ["#000000" "#e74c3c" "#b6e63e" "#e2c770" "#268bd2" "#fb2874" "#66d9ef" "#ffffff"])
 '(custom-safe-themes
   (quote
    ("43c1a8090ed19ab3c0b1490ce412f78f157d69a29828aa977dae941b994b4147" "9a155066ec746201156bb39f7518c1828a73d67742e11271e4f24b7b178c4710" "4a7abcca7cfa2ccdf4d7804f1162dd0353ce766b1277e8ee2ac7ee27bfbb408f" "d6922c974e8a78378eacb01414183ce32bc8dbf2de78aabcc6ad8172547cb074" "ff7625ad8aa2615eae96d6b4469fcc7d3d20b2e1ebc63b761a349bebbb9d23cb" "5900bec889f57284356b8216a68580bfa6ece73a6767dfd60196e56d050619bc" "d507c9e58cb0eb8508e15c8fedc2d4e0b119123fab0546c5fd30cadd3705ac86" "9f569b5e066dd6ca90b3578ff46659bc09a8764e81adf6265626d7dc0fac2a64" "611e38c2deae6dcda8c5ac9dd903a356c5de5b62477469133c89b2785eb7a14d" "b81bfd85aed18e4341dbf4d461ed42d75ec78820a60ce86730fc17fc949389b2" "8ed752276957903a270c797c4ab52931199806ccd9f0c3bb77f6f4b9e71b9272" "365d9553de0e0d658af60cff7b8f891ca185a2d7ba3fc6d29aadba69f5194c7f" default)))
 '(fci-rule-color "#555556")
 '(font-latex-fontify-script nil)
 '(jdee-db-active-breakpoint-face-colors (cons "#000000" "#fd971f"))
 '(jdee-db-requested-breakpoint-face-colors (cons "#000000" "#b6e63e"))
 '(jdee-db-spec-breakpoint-face-colors (cons "#000000" "#525254"))
 '(mac-command-modifier (quote super))
 '(mac-frame-tabbing nil)
 '(mac-right-option-modifier (quote left))
 '(mac-wheel-button-is-mouse-2 nil)
 '(org-agenda-files
   (quote
    ("~/Dropbox/Docs/LaTeX/- Stanford/Phil 273B - Metaethics/Phil237BPN.org")))
 '(org-fontify-done-headline t)
 '(org-fontify-quote-and-verse-blocks t)
 '(org-fontify-whole-heading-line t)
 '(org-latex-preview-ltxpng-directory "~/OrgTemp/")
 '(org-list-allow-alphabetical t)
 '(package-selected-packages
   (quote
    (company-quickhelp ido-completing-read+ fix-word pdf-tools no-littering leuven-theme fzf company-tern xref-js2 js2-refactor js2-mode elpy magit smartparens yasnippet bind-key diminish powerline rich-minority s popwin popup epl pkg-info nlinum math-symbol-lists async dash company helm-core wrap-region which-key px helm-company helm tabbar aggressive-indent smart-mode-line-powerline-theme use-package exec-path-from-shell smart-mode-line multiple-cursors browse-kill-ring deft rainbow-delimiters company-math flycheck company-auctex auctex-latexmk auctex)))
 '(preview-image-type (quote dvipng))
 '(preview-scale-function 1.0)
 '(reftex-cite-prompt-optional-args t)
 '(solarized-broken-srgb t)
 '(solarized-degrade nil)
 '(solarized-termcolors 256)
 '(vc-annotate-background "#000000")
 '(vc-annotate-color-map
   (list
    (cons 20 "#b6e63e")
    (cons 40 "#c4db4e")
    (cons 60 "#d3d15f")
    (cons 80 "#e2c770")
    (cons 100 "#ebb755")
    (cons 120 "#f3a73a")
    (cons 140 "#fd971f")
    (cons 160 "#fc723b")
    (cons 180 "#fb4d57")
    (cons 200 "#fb2874")
    (cons 220 "#f43461")
    (cons 240 "#ed404e")
    (cons 260 "#e74c3c")
    (cons 280 "#c14d41")
    (cons 300 "#9c4f48")
    (cons 320 "#77504e")
    (cons 340 "#555556")
    (cons 360 "#555556")))
 '(vc-annotate-very-old-color nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(font-latex-math-face ((t (:foreground "pale violet red"))))
 '(font-latex-subscript-face ((t nil)))
 '(font-latex-superscript-face ((t nil)))
 '(hl-line ((t (:background "#F6FECD" :underline nil)))))


;; gc - decrease threshold to 5 MB
(add-hook 'after-init-hook (lambda () (setq gc-cons-threshold (* 5 1024 1024))))

(load "server")
(unless (server-running-p) (server-start)) ; start emacs in server mode so that skim can talk to it

;; For exec-path-from-shell
(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))

;; This should always be at the end!
;;    Set alt to meta
;;    (setq mac-option-modifier 'meta)
;; Here we set cmd to meta, leaving alt available for alternative characters.
(setq mac-option-key-is-meta nil)
(setq mac-command-key-is-meta t)
(setq mac-command-modifier 'meta)
(setq mac-option-modifier nil)
;; Set fn to hyper
(setq ns-function-modifier 'hyper)
;; Also, don't pass uses of command to the system
(setq mac-pass-command-to-system nil)




;; init.el ends here


(setq gc-cons-threshold 1000000)

; (emacs-init-time)

(setq user-full-name "Benji Sparkes")
(setq user-mail-address "bsparkes@stanford.edu")

(add-hook 'focus-out-hook 'save-buffer)

(setq savehist-file "~/.emacs.d/savehist")
(setq savehist-additional-variables
      '(buffer-name-history
        compile-command
        extended-command-history
        file-name-history
        kill-ring
        regexp-search-ring
        search-ring))
(savehist-mode 1)

(tooltip-mode -1)
(setq tooltip-use-echo-area t)

(setq tab-width 2
      indent-tabs-mode nil)

;; Nobody likes to have to type out the full yes or no when Emacs asks. Which it does often. Make it one character.
(defalias 'yes-or-no-p 'y-or-n-p)

(setq echo-keystrokes 0.1
      use-dialog-box nil
      visible-bell t)
(show-paren-mode t)

(desktop-save-mode)
;; Some display settings
(setq-default indicate-empty-lines t)
(when (not indicate-empty-lines)
  (toggle-indicate-empty-lines))
(save-place-mode t)
(global-visual-line-mode t)
(setq-default line-spacing 2)

(global-hl-line-mode t)

;; Font Settings
(when (eq system-type 'darwin)
  ;; default Latin font (e.g. Input Mono)
  ;; Input is used to help with lag? It only has 4 different faces.
  (set-face-attribute 'default nil :family  "mononoki";"Luxi Mono";"Hack";"IBM Plex Mono";"Input Mono"
                      :height 130)
  )

;; (setq inhibit-compacting-font-caches 1)

(tool-bar-mode -1)
(toggle-scroll-bar -1)

(setq-default fill-column 1024)
(set-default 'truncate-lines nil)

(delete-selection-mode t)

(add-hook 'text-mode-hook '(lambda ()
                             (auto-fill-mode t)))

(add-hook 'prog-mode-hook 'subword-mode)

(global-font-lock-mode t)

(auto-fill-mode t)

(setq-default indicate-empty-lines t)
(setq-default show-trailing-whitespace t)

;(setq save-abbrevs 'silently)
;(setq-default abbrev-mode t)

(setq-default
  whitespace-line-column 80
  whitespace-style       '(face lines-tail))
(add-hook 'prog-mode-hook #'whitespace-mode)

(setq backup-directory-alist '(("." . "~/.emacs.d/backups")))
(setq
 backup-by-copying t       ; don't clobber symlinks
 kept-new-versions 10      ; keep 10 latest versions
 kept-old-versions 0       ; don't bother with old versions
 delete-old-versions t     ; don't ask about deleting old S versions
 version-control t         ; number backups
 vc-make-backup-files nil) ; backup version controlled files

(setq auto-save-interval 200)

(setq sentence-end-double-space nil)
;; Show line-number in the mode line
(line-number-mode 1)
;; Show column-number in the mode line
(column-number-mode 1)

;; For line numbers Line numbers are on in every buffer by default:
;; (global-linum-mode 1)

(global-auto-revert-mode t)

(let ((my-path (expand-file-name "/usr/local/bin:/usr/local/texlive/2017/bin/x86_64-darwin")))
  (setenv "PATH" (concat my-path ":" (getenv "PATH")))
  (add-to-list 'exec-path my-path))
;; LaTeX Stuff
(require 'auctex-latexmk)
(auctex-latexmk-setup)

(setq auctex-latexmk-inherit-TeX-PDF-mode t)
;; Only works with auctex loaded?
(load "auctex.el" nil t t)
;; (require 'tex-site)

(setq-default TeX-PDF-mode t)
;; Make emacs aware of multi-file projects
(setq-default TeX-master t)
(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq TeX-save-query nil)
(defvar latex-enable-folding t)
(add-hook 'LaTeX-mode-hook 'visual-line-mode)
(add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)   ; with AUCTeX LaTeX mode
;; (add-hook 'latex-mode-hook 'turn-on-reftex)   ; with Emacs latex mode

(defun latex-word-count ()
  (interactive)
  (shell-command (concat "texcount "
                         ;; "uncomment then options go here, such as "
                         "-unicode "
                         "-inc "
                         (shell-quote-argument buffer-file-name)))
  ;;Now the buffer file name is sent correctly to the shell,
  ;;regardless of platform
  )

(setq reftex-plug-into-AUCTeX t)
;; Only change sectioning colour
(setq font-latex-fontify-sectioning 'color)
;; Exclude bold/italic from keywords
;; (setq font-latex-deactivated-keyword-classes '("italic-command" "bold-command" "italic-declaration" "bold-declaration"))
;; TeX-electric-math
;; (add-hook 'plain-TeX-mode-hook
;;           (lambda () (set (make-variable-buffer-local 'TeX-electric-math)
;;                           (cons "$" "$"))))
;; (add-hook 'LaTeX-mode-hook
;;           (lambda () (set (make-variable-buffer-local 'TeX-electric-math)
;;                           (cons "\\(" "\\)"))))
;; LaTeX-electric-left-right-brace
;; (setq LaTeX-electric-left-right-brace t)
(setq TeX-electric-sub-and-superscript t)

(setq TeX-source-correlate-method 'synctex)
(add-hook 'LaTeX-mode-hook 'TeX-source-correlate-mode)

(setq TeX-view-program-list
      '(("PDF Viewer" "/Applications/Skim.app/Contents/SharedSupport/displayline -b -g %n %o %b")))
(setq TeX-view-program-selection '((output-pdf "PDF Viewer")))

(setq org-latex-listings 'minted)

(setq-default org-export-latex-minted-options
              '(("frame" "lines")
                ("fontsize" "\\scriptsize")
                ("linenos" "")))

;; (require 'helm-config)
(use-package helm
  :diminish helm-mode
  :init
  (progn
    (require 'helm-config)
    (setq helm-candidate-number-limit 100)
    ;; From https://gist.github.com/antifuchs/9238468
    (setq helm-idle-delay 0.01 ; update fast sources immediately (doesn't).
          helm-input-idle-delay 0.01    ; this actually updates things
                                        ; reeeelatively quickly.
          ;; helm-yas-display-key-on-candidate t
          ;; helm-quick-update t
          ;; helm-M-x-requires-pattern nil
          helm-ff-skip-boring-files t
          )
    (helm-mode))
  :bind (("C-c h" . helm-mini)
         ("C-h a" . helm-apropos)
         ("C-x C-b" . helm-buffers-list)
         ("C-x b" . helm-buffers-list)
         ("M-y" . helm-show-kill-ring)
         ("M-x" . helm-M-x)
         ("C-x c o" . helm-occur)
         ("C-x c s" . helm-swoop)
         ("C-x c y" . helm-yas-complete)
         ("C-x c Y" . helm-yas-create-snippet-on-region)
         ("C-x c b" . my/helm-do-grep-book-notes)
         ("C-x c SPC" . helm-all-mark-rings)
         ;; ("C-c h" .  helm-command-prefix)
         ("C-x C-f" . helm-find-files)
         ))
(setq helm-M-x-fuzzy-match t) ;; optional fuzzy matching for helm-M-x

(add-hook 'after-init-hook 'global-company-mode)
(company-auctex-init)
;; (add-hook 'TeX-mode-hook 'my-latex-mode-setup)
;; global activation of the unicode symbol completion
(add-to-list 'company-backends 'company-math-symbols-unicode)
(add-to-list 'company-backends '(company-capf
                                 :with company-dabbrev))

(eval-after-load 'company
  '(progn
     (define-key company-mode-map (kbd "C-:") 'helm-company)
     (define-key company-active-map (kbd "C-:") 'helm-company)))

;; (tabbar-mode 0)

(require 'tabbar)
(tabbar-mode 1)
(setq tabbar-use-images nil)

(which-key-mode)
(which-key-setup-minibuffer)
;; (setq which-key-popup-type 'minibuffer)
(setq which-key-idle-delay 0.1)
(setq which-key-max-display-columns nil)

(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)

(require 'deft)
(setq deft-extensions '("txt" "tex" "org"))
(setq deft-directory "~/Dropbox/Docs/")
(setq deft-recursive t)
(setq deft-use-filename-as-title t)
(setq deft-use-filter-string-for-filename t)
;; (global-set-key (kbd "C-x C-g") 'deft-find-file)

(require 'browse-kill-ring)

;; For a more compact mode line
;; (use-package smart-mode-line) ; need to fix.

;; I almost always want to go to the right indentation on the next line.
(global-set-key (kbd "RET") 'newline-and-indent)
;; Spaces only (no tab characters at all)!
(setq-default indent-tabs-mode nil)
;; For easy window scrolling up and down.
(global-set-key "\M-n" 'scroll-up-line)
(global-set-key "\M-p" 'scroll-down-line)

(require 'org)

;(add-hook 'org-mode-hook
;          (lambda () (face-remap-add-relative 'default :family "Input Mono")))

(setq org-format-latex-options
      '(:foreground default
                    :background default
                    :scale 1
                    :html-foreground "Black"
                    :html-background "Transparent"
                    :html-scale 1.0
                    :matchers ("begin" "$1" "$$" "\\(" "\\[")))

(setq org-adapt-indentation nil)

(font-lock-add-keywords
 'org-mode
 '(("\\(@[0-9]*[-]*[0-9]*@\\)" 1 font-lock-comment-face t)))

(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-cb" 'org-iswitchb)

(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))

(setq org-agenda-files (file-expand-wildcards "/Users/sparkes/Dropbox/Docs/Org/*.org"))

(setq-default org-todo-keywords '((sequence
                     "TODO(t)"
                     "FIXME(f)"
                     "IN-PROGRESS(p)"
                     "NEXT(n)"
                     "WAITING(w)"
                     "DONE(d)"
                     "CANCELLED(c)")))

(setq org-log-done 'time)
(setq org-log-done 'note)

(setq  org-directory "/Users/sparkes/Dropbox/Docs/Org")
(setq org-default-notes-file (concat org-directory "/OrgCapture.org"))

(setq org-src-fontify-natively t)

(defun my/org-mode-hook ()
;  "Stop the org-level headers from increasing in height relative to the other text."
;  (dolist (face '(org-level-1
;                  org-level-2
;                  org-level-3
;                  org-level-4
;                  org-level-5))
;    (set-face-attribute face nil :weight 'semi-bold :height 1.0))
)

(add-hook 'org-mode-hook 'my/org-mode-hook)

(add-hook 'org-load-hook
  (lambda ()
    (setq org-agenda-custom-commands
   '(("L" "my view"
      ((todo
        "TODO"
        ((org-agenda-overriding-header "=== TODO tasks without scheduled date ===")
         (org-agenda-skip-function '(org-agenda-skip-entry-if 'scheduled))
         (org-agenda-prefix-format '((todo . " %1c ")))))
       (agenda
        ""
        ((org-agenda-overriding-header "=== Scheduled tasks ===")
         (org-agenda-span 22)
         (org-agenda-prefix-format '((agenda . " %1c %?-12t% s")))))))))))

(org-babel-do-load-languages
 'org-babel-load-languages
 '(
   (awk)
   (C)
   (calc)
   (clojure)
   (dot . t)
   (emacs-lisp . t)
   (gnuplot)
   (haskell)
   (io)
   (java)
   (js . t)
   (latex . t)
   (lisp . t)
   (matlab)
   (org . t)
   (perl)
   (picolisp)
   (plantuml)
   (python . t)
   (R . t)
   (ref)
   (ruby . t)
   (scheme)
   (sh)
   (shell)
   (shen)
   (sqlite)
   ))

;; Aggressive indent everywhere
(global-aggressive-indent-mode 1)

(use-package wrap-region
  :ensure t
  :config
  ;; (wrap-region-global-mode t)
  (wrap-region-add-wrappers
   '(;; ("(" ")")
     ;; ("[" "]")
     ;; ("{" "}")
     ;; ("<" ">")
     ;; ("'" "'")
     ;; ("\"" "\"")
     ("`" "'"       "q")
     ("``" "''"     "Q")
     ("*" "*"       "b"    org-mode)             ; bolden
     ("*" "*"       "*"    org-mode)             ; bolden
     ("/" "/"       "i"    org-mode)             ; italics
     ("/" "/"       "/"    org-mode)             ; italics
     ("~" "~"       "c"    org-mode)             ; code
     ("~" "~"       "~"    org-mode)             ; code
     ("=" "="       "v"    org-mode)             ; verbatim
     ("=" "="       "="    org-mode)             ; verbatim
     ("@" "@"       "@"    org-mode)             ; ref
     ("$" "$"       "$"    org-mode)             ; TeX Math
     ("\\(" "\\)"   "m"    org-mode)             ; LaTeX Math
     ("\\[" "\\]"   "d"    org-mode)             ; LaTeX Diplay-math
     ("`" "'"   "c"       lisp-mode)             ; code
     ))
  :diminish wrap-region-mode)

;; For killing the buffer I'm looking at, capitalised then does the default
(global-set-key (kbd "C-x k") 'kill-this-buffer)
(global-set-key (kbd "C-x K") 'kill-buffer)

;; https://github.com/Fuco1/smartparens
(require 'smartparens-config)
(require 'smartparens-latex)
(smartparens-global-mode t)
(sp-with-modes
    '(tex-mode plain-tex-mode latex-mode LaTeX-mode)

  (sp-local-pair "\\(" "\\)"
                 :unless '(sp-point-before-word-p
                           sp-point-before-same-p
                           sp-latex-point-after-backslash)
                 :trigger-wrap "$"
                 :trigger "$")

  (sp-local-pair "\\[" "\\]"
                 :unless '(sp-point-before-word-p
                           sp-point-before-same-p
                           sp-latex-point-after-backslash)))

(global-set-key (kbd "C-x g") 'magit-status)

;; Themes
;; (load-theme 'monokai t)
;; (load-theme 'sanityinc-tomorrow-eighties t)

;; to get rid of buffer-face on shift click
(define-key global-map (kbd "<S-down-mouse-1>") 'mouse-save-then-kill)
;; to set right click to a menu bar instead of yanking
(global-set-key [mouse-2] 'mouse-popup-menubar-stuff)

;; Solves pointer problems?
(if (daemonp)
    (add-hook 'after-make-frame-functions
              (lambda (frame)
                (with-selected-frame frame
                  (load-theme  'leuven t))))
  (load-theme  'leuven t))

;; For loading themes
;; (defadvice load-theme (before theme-dont-propagate activate)
;;   (mapc #'disable-theme custom-enabled-themes))

(require 'js2-mode)
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))

;; Better imenu
(add-hook 'js2-mode-hook #'js2-imenu-extras-mode)

(require 'js2-refactor)
(require 'xref-js2)

(add-hook 'js2-mode-hook #'js2-refactor-mode)
(js2r-add-keybindings-with-prefix "C-c C-r")
(define-key js2-mode-map (kbd "C-k") #'js2r-kill)

;; js-mode (which js2 is based on) binds "M-." which conflicts with xref, so
;; unbind it.
(define-key js-mode-map (kbd "M-.") nil)

(add-hook 'js2-mode-hook (lambda ()
                           (add-hook 'xref-backend-functions #'xref-js2-xref-backend nil t)))

(define-key js2-mode-map (kbd "C-k") #'js2r-kill)

;; setting the amount of syntax highligting
(setq js2-highlight-level 3)

;; (require 'company-mode)
(require 'company-tern)

(add-to-list 'company-backends 'company-tern)
(add-hook 'js2-mode-hook (lambda ()
                           (tern-mode)
                           (company-mode)))

;; Disable completion keybindings, as we use xref-js2 instead
(define-key tern-mode-keymap (kbd "M-.") nil)
(define-key tern-mode-keymap (kbd "M-,") nil)

; (package-initialize)
; (elpy-enable)

;; Better line numbers
(use-package nlinum
  :config
  (progn
    ;; (setq nlinum-format " %d ") ; 1 space padding on each side of line number
    ;(setq nlinum-highlight-current-line t)
    ;; (global-nlinum-mode 1)

    ;; (defun modi/turn-on-nlinum ()
    ;;   "Turn on nlinum mode in specific modes."
    ;;   (interactive)
    ;;   (if modi/linum-mode-enable-global
    ;;       (progn
    ;;         (dolist (hook modi/linum-mode-hooks)
    ;;           (remove-hook hook #'nlinum-mode))
    ;;         (global-nlinum-mode 1))
    ;;     (progn
    ;;       (when global-linum-mode
    ;;         (global-nlinum-mode -1))
    ;;       (dolist (hook modi/linum-mode-hooks)
    ;;         (add-hook hook #'nlinum-mode)))))

    ;; (defun modi/turn-off-nlinum ()
    ;;   "Unhook nlinum mode from various major modes."
    ;;   (interactive)
    ;;   (global-nlinum-mode -1)
    ;;   (dolist (hook modi/linum-mode-hooks).
    ;;     (remove-hook hook #'nlinum-mode)))
    ))
(add-hook 'LaTeX-mode-hook 'nlinum-mode)
(add-hook 'latex-mode-hook 'nlinum-mode)
(add-hook 'js-mode-hook 'nlinum-mode)

;; For multiple cursors
(use-package multiple-cursors
        :ensure t)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "M-<M-down-mouse-1>") 'mc/add-cursor-on-click)

(use-package undo-tree
    :ensure t
    :init
(global-undo-tree-mode))

(setq ispell-program-name "aspell") ; could be ispell as well, depending on your preferences
(setq ispell-dictionary "british") ; this can obviously be set to any language your spell-checking program supports
; (add-hook 'LaTeX-mode-hook 'flyspell-mode)
; (add-hook 'LaTeX-mode-hook 'flyspell-buffer)
; (add-hook 'org-mode-hook 'flyspell-mode)
; (add-hook 'org-mode-hook 'flyspell-buffer)
(add-hook 'org-mode-hook 'LaTeX-math-mode)

; (pdf-tools-install)

(require 'ido)
(ido-mode 1)
(setq ido-everywhere t
      ido-enable-flex-matching t
      ido-ignore-buffers '("\\` " "*Messages*" "*Completions*" "*Buffer List*"
                           "*scratch*" "*Help*" "*Backtrace*"))

(require 'ido-completing-read+)
(ido-ubiquitous-mode 1)

(setq magit-completing-read-function 'magit-ido-completing-read)

(global-set-key (kbd "C-x C-b") 'ibuffer)

(require 'fix-word)

(global-set-key (kbd "M-u") #'fix-word-upcase)
(global-set-key (kbd "M-l") #'fix-word-downcase)
(global-set-key (kbd "M-c") #'fix-word-capitalize)

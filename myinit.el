
;; From https://github.com/howardabrams/dot-files/blob/master/emacs.org
(setq gc-cons-threshold 1000000)

;; (emacs-init-time)

;; Added by Package.el.
;; Also, two additional package sources, as ELPA doesn't have it all
(package-initialize)
;;(add-to-list 'package-archives
;;             '("marmalade" . "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives '("org" . "https://orgmode.org/elpa/") t)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/") t)
(setq package-archive-enable-alist '(("melpa" deft magit)))

;; For exec-path-from-shell
(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))

;; Disable the toolbar
(tool-bar-mode -1)
;; Disable the scrollbar
(toggle-scroll-bar -1)

;; Set line wrapping
(setq-default fill-column 1024)
(set-default 'truncate-lines nil)

;; Basic Info
(setq user-full-name "Benji Sparkes")
(setq user-mail-address "bsparkes@stanford.edu")

;; Change backup location and make some backup settings
;; Largely from: http://pragmaticemacs.com/emacs/auto-save-and-backup-every-save/
(setq backup-directory-alist '(("." . "~/.emacs.d/backups")))
(setq
 backup-by-copying t       ; don't clobber symlinks
 kept-new-versions 10      ; keep 10 latest versions
 kept-old-versions 0       ; don't bother with old versions
 delete-old-versions t     ; don't ask about deleting old S versions
 version-control t         ; number backups
 vc-make-backup-files nil) ; backup version controlled files

;; auto save often
;; every 20 characters typed is the minimum
(setq auto-save-interval 200)

;; For recognising that sentences end with a single space
(setq sentence-end-double-space nil)

;; Font Settings
(when (eq system-type 'darwin)
  ;; default Latin font (e.g. Input Mono)
  ;; Input is used to help with lag? It only has 4 different faces.
  (set-face-attribute 'default nil :family  "mononoki";"Luxi Mono";"Hack";"IBM Plex Mono";"Input Mono"
                      :height 130)
  ;; you may want to add different for other charset in this way.
  )

;; (setq inhibit-compacting-font-caches 1)

;; Some startup settings
(desktop-save-mode)
;; Some display settings
(setq-default indicate-empty-lines t)
(when (not indicate-empty-lines)
  (toggle-indicate-empty-lines))
(save-place-mode t)
(global-visual-line-mode t)
(setq-default line-spacing 2)

;; Show line-number in the mode line
(line-number-mode 1)
;; Show column-number in the mode line
(column-number-mode 1)

;; The following is for line numbers Line numbers are on in every
;; buffer by default
;; (global-linum-mode 1)

;; Indentation
(setq tab-width 2
      indent-tabs-mode nil)

;; Yes and No
;; Nobody likes to have to type out the full yes or no when Emacs asks. Which it does often. Make it one character.
(defalias 'yes-or-no-p 'y-or-n-p)

;; Misc
;; Turn down the time to echo keystrokes so I don't have to wait around for things to happen. Dialog boxes are also a bit annoying, so just have Emacs use the echo area for everything. Beeping is for robots, and I am not a robot. Use a visual indicator instead of making horrible noises. Oh, and always highlight parentheses. A person could go insane without that.
(setq echo-keystrokes 0.1
      use-dialog-box nil
      visible-bell t)
(show-paren-mode t)

;; By default Emacs will display its tooltips in a separate frame. If you want to force Emacs to use the echo area exclusively, you can do that with this handy code snippet:
(tooltip-mode -1)
(setq tooltip-use-echo-area t)

;; For spell checking
(setq ispell-program-name "aspell") ; could be ispell as well, depending on your preferences
(setq ispell-dictionary "british") ; this can obviously be set to any language your spell-checking program supports
(add-hook 'LaTeX-mode-hook 'flyspell-mode)
(add-hook 'LaTeX-mode-hook 'flyspell-buffer)
(add-hook 'org-mode-hook 'flyspell-mode)
(add-hook 'org-mode-hook 'flyspell-buffer)
(add-hook 'org-mode-hook 'LaTeX-math-mode)

;; LaTeX Stuff

;; Tells emacs where to find LaTeX.
(let ((my-path (expand-file-name "/usr/local/bin:/usr/local/texlive/2016/bin/x86_64-darwin")))
  (setenv "PATH" (concat my-path ":" (getenv "PATH")))
  (add-to-list 'exec-path my-path))
;; LaTeX Stuff
(require 'auctex-latexmk)
(auctex-latexmk-setup)

;; To make a pdf
(setq auctex-latexmk-inherit-TeX-PDF-mode t)
;; Only works with auctex loaded?
(load "auctex.el" nil t t)
;; (require 'tex-site)

;; Use PDF mode by default
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

;; For word count
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

;; ReFtex from https://piotrkazmierczak.com/2010/emacs-as-the-ultimate-latex-editor/
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

;; use Skim as default pdf viewer
;; Skim's displayline is used for forward search (from .tex to .pdf)
;; option -b highlights the current line; option -g opens Skim in the background
;; For this to work, it seems one needs no spaces in the file name
(setq TeX-view-program-list
      '(("PDF Viewer" "/Applications/Skim.app/Contents/SharedSupport/displayline -b -g %n %o %b")))
(setq TeX-view-program-selection '((output-pdf "PDF Viewer")))

(load "server")
(unless (server-running-p) (server-start)) ; start emacs in server mode so that skim can talk to it

;; CDLaTex
;; (add-hook 'LaTeX-mode-hook 'turn-on-cdlatex) ; with AUCTeX LaTeX mode
;; (add-hook 'latex-mode-hook 'turn-on-cdlatex) ; with Emacs latex mode
;; (add-hook 'org-mode-hook 'turn-off-org-cdlatex) ; with org-mode
;; (setq cdlatex-simplify-sub-super-scripts nil)

;; Helm
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


;; Company Mode
(add-hook 'after-init-hook 'global-company-mode)
(company-auctex-init)
;; (add-hook 'TeX-mode-hook 'my-latex-mode-setup)
;; global activation of the unicode symbol completion
(add-to-list 'company-backends 'company-math-symbols-unicode)
(add-to-list 'company-backends '(company-capf
                                 :with company-dabbrev))

;; and with helm
(eval-after-load 'company
  '(progn
     (define-key company-mode-map (kbd "C-:") 'helm-company)
     (define-key company-active-map (kbd "C-:") 'helm-company)))


;; For tabbar
(require 'tabbar)
(tabbar-mode t)
(setq tabbar-use-images nil)

;; For the amazing which-key
(which-key-mode)
(which-key-setup-minibuffer)
;; (setq which-key-popup-type 'minibuffer)
(setq which-key-idle-delay 0.1)
(setq which-key-max-display-columns nil)

;; rainbow-delimiters
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)

;; For reloading of bib files, apparently
(global-auto-revert-mode t)

;; Deft settings
(require 'deft)
(setq deft-extensions '("txt" "tex" "org"))
(setq deft-directory "~/Dropbox/Docs/")
(setq deft-recursive t)
(setq deft-use-filename-as-title t)
(setq deft-use-filter-string-for-filename t)
;; (global-set-key (kbd "C-x C-g") 'deft-find-file)

;; Browse kill ring
(require 'browse-kill-ring)

;; For multiple cursors
(require 'multiple-cursors)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "M-<M-down-mouse-1>") 'mc/add-cursor-on-click)

;; For a more compact mode line
;; (use-package smart-mode-line) ; need to fix.

;; I almost always want to go to the right indentation on the next line.
(global-set-key (kbd "RET") 'newline-and-indent)
;; Spaces only (no tab characters at all)!
(setq-default indent-tabs-mode nil)
;; For easy window scrolling up and down.
(global-set-key "\M-n" 'scroll-up-line)
(global-set-key "\M-p" 'scroll-down-line)

;; Org mode
; Activate org-mode
(require 'org)
;; and some more org stuff
;; Fixed width org
(add-hook 'org-mode-hook
          (lambda () (face-remap-add-relative 'default :family "Input Mono")))
;; LaTeX size in org
(setq org-format-latex-options
      '(:foreground default
                    :background default
                    :scale 1
                    :html-foreground "Black"
                    :html-background "Transparent"
                    :html-scale 1.0
                    :matchers ("begin" "$1" "$$" "\\(" "\\[")))
;; prevent demoting heading also shifting text inside sections
(setq org-adapt-indentation nil)
;; Adding fontlock for @nums@ page references
(font-lock-add-keywords
 'org-mode
 '(("\\(@[0-9]*[-]*[0-9]*@\\)" 1 font-lock-comment-face t)))
;; And some org-mode keybindings
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-cb" 'org-iswitchb)

;; auto add time to done
(setq org-log-done 'time)

;; Org capture
(setq  org-directory "/Users/sparkes/Dropbox/Docs/Org")
(setq org-default-notes-file (concat org-directory "/OrgCapture.org"))

;; fontify code in code blocks
(setq org-src-fontify-natively t)

;; Header size
(defun my/org-mode-hook ()
  "Stop the org-level headers from increasing in height relative to the other text."
  (dolist (face '(org-level-1
                  org-level-2
                  org-level-3
                  org-level-4
                  org-level-5))
    (set-face-attribute face nil :weight 'semi-bold :height 1.0)))

(add-hook 'org-mode-hook 'my/org-mode-hook)

;;  http://orgmode.org/guide/Activation.html#Activation
;; The following lines are always needed.  Choose your own keys.
(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))

;; Including all org files from a directory into the agenda
(setq org-agenda-files (file-expand-wildcards "/Users/sparkes/Dropbox/Docs/Org/*.org"))


;; Add babel inline code execution
(org-babel-do-load-languages ; babel, for executing code in org-mode.
 'org-babel-load-languages   ; load all language marked with (lang . t).
 '((C)
   (R . t)
   (awk)
   (calc)
   (clojure)
   (dot . t)
   (emacs-lisp . t)
   (gnuplot)
   (haskell)
   (io)
   (java)
   (js)
   (latex . t)
   (lisp)
   (matlab)
   (org . t)
   (perl)
   (picolisp)
   (plantuml)
   (python . t)
   (ref)
   (ruby)
   (sh)
   (shen)
   ))


;; For saving history
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


;; For goto-chg
(require 'goto-chg)
(global-set-key (kbd "s-.") 'goto-last-change)
(global-set-key (kbd "s-,") 'goto-last-change-reverse)

;; Aggressive indent everywhere
(global-aggressive-indent-mode 1)


;; ;; Disable pixel-by-pixel scrolling, since it's extremely choppy.
;; (setq mac-mouse-wheel-smooth-scroll nil)
;; ;; Keyboard smooth scrolling: Prevent the awkward "snap to re-center" when
;; ;; the text cursor moves off-screen. Instead, only scroll the minimum amount
;; ;; necessary to show the new line. (A number of 101+ disables re-centering.)
;; (setq scroll-conservatively 101)

;; ;; Optimize mouse wheel scrolling for smooth-scrolling trackpad use.
;; ;; Trackpads send a lot more scroll events than regular mouse wheels,
;; ;; so the scroll amount and acceleration must be tuned to smooth it out.
;; (setq
;;  ;; If the frame contains multiple windows, scroll the one under the cursor
;;  ;; instead of the one that currently has keyboard focus.
;;  mouse-wheel-follow-mouse 't
;;  ;; Completely disable mouse wheel acceleration to avoid speeding away.
;;  mouse-wheel-progressive-speed nil
;;  ;; The most important setting of all! Make each scroll-event move 2 lines at
;;  ;; a time (instead of 5 at default). Simply hold down shift to move twice as
;;  ;; fast, or hold down control to move 3x as fast. Perfect for trackpads.
;;  mouse-wheel-scroll-amount '(2 ((shift) . 4) ((control) . 6)))

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

;; Better line numbers
(use-package nlinum
  :config
  (progn
    ;; (setq nlinum-format " %d ") ; 1 space padding on each side of line number
    (setq nlinum-highlight-current-line t)
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


(require 'buffer-move)
(global-set-key (kbd "<C-S-up>")     'buf-move-up)
(global-set-key (kbd "<C-S-down>")   'buf-move-down)
(global-set-key (kbd "<C-S-left>")   'buf-move-left)
(global-set-key (kbd "<C-S-right>")  'buf-move-right)

;; Magit
(global-set-key (kbd "C-x g") 'magit-status)

;; Python

(package-initialize)
(elpy-enable)

;; Themes
;; (load-theme 'monokai t)
;; (load-theme 'solarized t)
;; (load-theme 'sanityinc-tomorrow-eighties t)

;; to get rid of buffer-face on shift click
(define-key global-map (kbd "<S-down-mouse-1>") 'mouse-save-then-kill)
;; to set right click to a menu bar instead of yanking
(global-set-key [mouse-2] 'mouse-popup-menubar-stuff)

;; Solarized
;; (setq solarized-distinct-fringe-background t)
;; (setq solarized-high-contrast-mode-line t)
;; (setq solarized-use-more-italic t)
;; Avoiding font size changes
;; (setq solarized-height-minus-1 1.0)
;; (setq solarized-height-plus-1 1.0)
;; (setq solarized-height-plus-2 1.0)
;; (setq solarized-height-plus-3 1.0)
;; (setq solarized-height-plus-4 1.0)

;; (load-theme 'solarized-dark t)
;; (load-theme 'doom-tomorrow-night t)

;; (require 'doom-themes)

;; ;; Global settings (defaults)
;; (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
;;       doom-themes-enable-italic t) ; if nil, italics is universally disabled

;; (doom-themes-org-config)

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

;; JavaScript

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

;; Tern
;; (require 'company-mode)
(require 'company-tern)

(add-to-list 'company-backends 'company-tern)
(add-hook 'js2-mode-hook (lambda ()
                           (tern-mode)
                           (company-mode)))

;; Disable completion keybindings, as we use xref-js2 instead
(define-key tern-mode-keymap (kbd "M-.") nil)
(define-key tern-mode-keymap (kbd "M-,") nil)

;; To save buffer on losing focus
(add-hook 'focus-out-hook 'save-buffer)


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

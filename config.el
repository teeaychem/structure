(defun ambrevar/reset-gc-cons-threshold ()
  (setq gc-cons-threshold (car (get 'gc-cons-threshold 'standard-value))))
(setq gc-cons-threshold (* 64 1024 1024))
(add-hook 'after-init-hook #'ambrevar/reset-gc-cons-threshold)

(setq default-file-name-handler-alist file-name-handler-alist)
(setq file-name-handler-alist nil)
(defun ambrevar/reset-file-name-handler-alist ()
  (setq file-name-handler-alist default-file-name-handler-alist))
(add-hook 'after-init-hook #'ambrevar/reset-file-name-handler-alist)

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

(defalias 'yes-or-no-p 'y-or-n-p)

(setq echo-keystrokes 0.1
      use-dialog-box nil
      visible-bell t)
(show-paren-mode t)

(set-locale-environment "en_GB.UTF-8")
(setenv "LANG" "en_GB.UTF-8")

(desktop-save-mode)
;; Some display settings
(setq-default indicate-empty-lines t)
(when (not indicate-empty-lines)
  (toggle-indicate-empty-lines))
(save-place-mode t)
(global-visual-line-mode t)
(setq-default line-spacing 2)

; (global-hl-line-mode t)

;; Font Settings
(when (eq system-type 'darwin)
;; default Latin font (e.g. Input Mono)
;; Input is used to help with lag? It only has 4 different faces.
(set-face-attribute 'default nil :family "Source Code Pro";"Operator Mono";"PragmataProLiga";"Source Code Pro";"Fira Mono" ;"Anonymous Pro";"Fantasque Sans Mono";"mononoki";"Hack";"IBM Plex Mono";"Input Mono"
:height 150
)
)
(setq-default mac-allow-anti-aliasing nil)
(setq inhibit-compacting-font-caches t)

(tool-bar-mode -1)
(toggle-scroll-bar -1)

(setq-default fill-column 1024)
(set-default 'truncate-lines nil)

(global-set-key (kbd "C-x k") 'kill-this-buffer)
(global-set-key (kbd "C-x K") 'kill-buffer)

(add-to-list 'default-frame-alist '(ns-transparent-titlebar . t))
(add-to-list 'default-frame-alist '(ns-appearance . dark))

(delete-selection-mode t)

(add-hook 'text-mode-hook #'(lambda ()
                             (auto-fill-mode t)))

(add-hook 'prog-mode-hook 'subword-mode)

(require 'font-lock)
(setq font-lock-maximum-decoration t)
(global-font-lock-mode t)
(global-hi-lock-mode nil)
(setq jit-lock-contextually t)
(setq jit-lock-stealth-verbose t)

(auto-fill-mode t)

(setq-default indicate-empty-lines t)
(setq-default show-trailing-whitespace t)

;(setq save-abbrevs 'silently)
;(setq-default abbrev-mode t)

;; (setq-default
;;   whitespace-line-column 80
;;   whitespace-style       '(face lines-tail))
;; (add-hook 'prog-mode-hook #'whitespace-mode)

(global-set-key (kbd "RET") 'newline-and-indent)

(setq-default indent-tabs-mode nil)

(global-set-key "\M-n" 'scroll-up-line)
(global-set-key "\M-p" 'scroll-down-line)

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

(global-auto-revert-mode t)

(define-key key-translation-map (kbd "¥") (kbd "\\")) ; ¥ to \

(setq use-package-always-ensure t)

;(when (memq window-system '(mac ns x))
;  (exec-path-from-shell-initialize))

;(let ((my-path (expand-file-name "/usr/local/bin:/usr/local/texlive/2022/bin/universal-darwin")))
(let ((my-path (expand-file-name "/usr/local/bin:/usr/local/texlive/2022basic/bin/universal-darwin")))
  (setenv "PATH" (concat my-path ":" (getenv "PATH")))
  (add-to-list 'exec-path my-path))

(require 'auctex-latexmk)
(auctex-latexmk-setup)

(setq-default TeX-PDF-mode t)
;; Make emacs aware of multi-file projects
(setq-default TeX-master "master") ; All master files called "master".
(setq-default TeX-master nil)

(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq TeX-save-query nil)
(add-hook 'LaTeX-mode-hook 'visual-line-mode)
(add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)   ; with AUCTeX LaTeX mode
;; (add-hook 'latex-mode-hook 'turn-on-reftex)   ; with Emacs latex mode

(defun latex-word-count ()
  (interactive)
  (shell-command (concat "texcount"
                         ;; "uncomment then options go here, such as "
                         " -unicode"
                         " -inc "
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
(add-hook 'plain-TeX-mode-hook
          (lambda () (set (make-variable-buffer-local 'TeX-electric-math)
                          (cons "$" "$"))))
;
;(add-hook 'LaTeX-mode-hook
;          (lambda () (set (make-variable-buffer-local 'TeX-electric-math)
;                          (cons "\\(" "\\)"))))
;(setq LaTeX-electric-left-right-brace t)
(setq TeX-electric-sub-and-superscript t)

(setq TeX-source-correlate-method 'synctex)
(add-hook 'LaTeX-mode-hook 'TeX-source-correlate-mode)

(setq TeX-view-program-selection '((output-pdf "PDF Viewer")))
(setq TeX-view-program-list
      '(("PDF Viewer" "/Applications/Skim.app/Contents/SharedSupport/displayline -r -b -g %n %o %b")))

(setq org-latex-listings 'minted)

(setq-default org-export-latex-minted-options
              '(("frame" "lines")
                ("fontsize" "\\scriptsize")
                ("linenos" "")))

(use-package helm
  ;; :init
  :config
  (setq
   helm-quick-update t ; do not display invisible candidates
   helm-idle-delay 0.01 ; be idle for this many seconds, before updating in delayed sources.
   helm-input-idle-delay 0.01 ; be idle for this many seconds, before updating candidate buffer
   helm-split-window-default-side 'other ;; open helm buffer in another window
   helm-split-window-in-side-p t ;; open helm buffer inside current window, not occupy whole other window
   helm-candidate-number-limit 100 ; limit the number of displayed canidates
   helm-move-to-line-cycle-in-source nil ; move to end or beginning of source when reaching top or bottom of source.
   ;; helm-command
   helm-M-x-requires-pattern 0     ; show all candidates when set to 0
   )
  :bind (("C-c h" . helm-mini)
         ("C-h a" . helm-apropos)
         ("C-x C-b" . helm-buffers-list)
         ("C-x b" . helm-buffers-list)
         ("M-y" . helm-show-kill-ring)
         ("M-x" . helm-M-x)
         ("C-x c o" . helm-occur)
         ("C-x c s" . helm-swoop)
         ("C-x c b" . my/helm-do-grep-book-notes)
         ("C-x c SPC" . helm-all-mark-rings)
         ;; ("C-c h" .  helm-command-prefix)
         ("C-x C-f" . helm-find-files)
         ))
(setq helm-M-x-fuzzy-match t) ;; optional fuzzy matching for helm-M-x

(add-hook 'after-init-hook 'global-company-mode)
(company-auctex-init)

(add-to-list 'company-backends 'company-math-symbols-unicode)
(add-to-list 'company-backends '(company-capf
                                 :with company-dabbrev))

(eval-after-load 'company
  '(progn
     (define-key company-mode-map (kbd "C-:") 'helm-company)
     (define-key company-active-map (kbd "C-:") 'helm-company)))

(setq-default company-dabbrev-downcase nil)

;  (require 'tabbar)
;  (tabbar-mode 1)
;  (setq tabbar-use-images nil)

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
(global-set-key (kbd "C-x C-\\") 'deft-find-file)

(require 'browse-kill-ring)

(require 'org)

;; (add-hook 'org-mode-hook
;;  (lambda () (face-remap-add-relative 'default :family "Input Mono")))

(setq org-format-latex-options
      '(:foreground default
                    :background default
                    :scale 1
                    :html-foreground "Black"
                    :html-background "Transparent"
                    :html-scale 1.0
                    :matchers ("begin" "$1" "$$" "\\(" "\\[")))

(setq org-adapt-indentation nil)

;; (font-lock-add-keywords
;;  'org-mode
;;  '(("\\(@[0-9]*[-]*[0-9]*@\\)" 1 font-lock-comment-face t)))

;; (global-set-key "\C-cl" 'org-store-link)
;; (global-set-key "\C-ca" 'org-agenda)
;; (global-set-key "\C-cc" 'org-capture)
;; (global-set-key "\C-cb" 'org-iswitchb)

(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))

(setq org-agenda-files (file-expand-wildcards "/Users/sparkes/Dropbox/Docs/Org/*.org"))

;; (setq-default org-todo-keywords '((sequence
;;                       "TODO(t)"
;;                       "FIXME(f)"
;;                       "IN-PROGRESS(p)"
;;                       "NEXT(n)"
;;                       "WAITING(w)"
;;                       "|"
;;                       "DONE(d)"
;;                       "COMPLETED(c)"
;;                       "CANCELLED(x)")))
;; (setq org-log-done t)

(setq org-log-done 'time)
(setq org-log-done 'note)

(setq  org-directory "/Users/sparkes/Dropbox/Docs/Org")
(setq org-default-notes-file (concat org-directory "/OrgCapture.org"))

;; (setq org-src-fontify-natively t)

;; (defun my/org-mode-hook ()
;  "Stop the org-level headers from increasing in height relative to the other text."
;  (dolist (face '(org-level-1
;                  org-level-2
;                  org-level-3
;                  org-level-4
;                  org-level-5))
;    (set-face-attribute face nil :weight 'semi-bold :height 1.0))
;; )
;; (
;; add-hook 'org-mode-hook 'my/org-mode-hook)

;; (add-hook 'org-load-hook
;;   (lambda ()
;;     (setq org-agenda-custom-commands
;;    '(("L" "my view"
;;       ((todo
;;         "TODO"
;;         ((org-agenda-overriding-header "=== TODO tasks without scheduled date ===")
;;          (org-agenda-skip-function '(org-agenda-skip-entry-if 'scheduled))
;;          (org-agenda-prefix-format '((todo . " %1c ")))))
;;        (agenda
;;         ""
;;         ((org-agenda-overriding-header "=== Scheduled tasks ===")
;;          (org-agenda-span 22)
;;          (org-agenda-prefix-format '((agenda . " %1c %?-12t% s")))))))))))

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

;; https://github.com/Fuco1/smartparens
(require 'smartparens-config)
(require 'smartparens-latex)
(smartparens-global-mode t)

;; needed to ensure text isn't deleted
;; (https://github.com/Fuco1/smartparens/issues/834)
(define-key LaTeX-mode-map (kbd "$") 'self-insert-command)

(sp-with-modes
    '(tex-mode plain-tex-mode latex-mode LaTeX-mode org-mode)
  (sp-local-pair "\\(" "\\)"
                 ;; :actions '(:rem autoskip)
                 ;; :skip-match 'sp-latex-skip-match-apostrophe
                 :unless '(;sp-point-before-word-p
                           ;; sp-point-before-same-p
                           sp-latex-point-after-backslash)
                 :trigger-wrap "$"
                 :trigger "$")
  ;; (sp-local-pair "\\[" "\\]"
  ;;             :unless '(sp-point-before-word-p
  ;;                       sp-point-before-same-p
  ;;                      sp-latex-point-after-backslash))
  )

(global-set-key (kbd "C-x g") 'magit-status)

;; to get rid of buffer-face on shift click
(define-key global-map (kbd "<S-down-mouse-1>") 'mouse-save-then-kill)
;; to set right click to a menu bar instead of yanking
(global-set-key [mouse-2] 'mouse-popup-menubar-stuff)

;; Solves pointer problems?
; (if (daemonp)
;    (add-hook 'after-make-frame-functions
;              (lambda (frame)
;                (with-selected-frame frame
;                  (load-theme  'leuven t))))

(load-theme 'dracula t)

;; For loading themes
;; (defadvice load-theme (before theme-dont-propagate activate)
;;   (mapc #'disable-theme custom-enabled-themes))

;; (require 'js2-mode)
;; (add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))

; set tabs to 2
;; (add-hook 'js2-mode-hook (lambda () (setq js2-basic-offset 2)))

;; Better imenu
;; (add-hook 'js2-mode-hook #'js2-imenu-extras-mode)

;; (require 'js2-refactor)
;; (
;; require 'xref-js2)

;; (add-hook 'js2-mode-hook #'js2-refactor-mode)
;; (
;;  js2r-add-keybindings-with-prefix "C-c C-r")
;; (
;; define-key js2-mode-map (kbd "C-k") #'js2r-kill)

;; js-mode (which js2 is based on) binds "M-." which conflicts with xref, so
;; unbind it.
;; (define-key js-mode-map (kbd "M-.") nil)

;; (add-hook 'js2-mode-hook (lambda ()
;;                            (add-hook 'xref-backend-functions #'xref-js2-xref-backend nil t)))

;; (define-key js2-mode-map (kbd "C-k") #'js2r-kill)

;; ;; setting the amount of syntax highligting
;; (setq js2-highlight-level 3)

; (elpy-enable)
;; (require 'python-mode)

;; (require 'py-autopep8)
;; (add-hook 'python-mode-hook 'py-autopep8-enable-on-save)

;(defun my/python-mode-hook ()
;  (add-to-list 'company-backends 'company-jedi))
;
;(add-hook 'python-mode-hook 'my/python-mode-hook)

(add-hook 'LaTeX-mode-hook 'display-line-numbers-mode)
(add-hook 'latex-mode-hook 'display-line-numbers-mode)
(add-hook 'js-mode-hook 'display-line-numbers-mode)

;; For multiple cursors
(use-package multiple-cursors
  :ensure t)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "M-<M-down-mouse-1>") 'mc/add-cursor-on-click)
;; (global-set-key (kbd "s-d") 'mc/mark-next-like-this)        ;; Cmd+d select next occurrence of region
;;  (global-set-key (kbd "s-D") 'mc/mark-all-dwim)              ;; Cmd+Shift+d select all occurrences
;;  (global-set-key (kbd "M-s-l") 'mc/edit-beginnings-of-lines) ;; Alt+Cmd+d add cursor to each line in region

(use-package undo-tree
  :ensure t
  :init
  (global-undo-tree-mode))

(setq ispell-program-name "aspell") ; could be ispell as well, depending on your preferences
(setq ispell-dictionary "british") ; this can obviously be set to any language your spell-checking program supports
(customize-set-variable 'ispell-extra-args '("--sug-mode=ultra"))
(add-hook 'LaTeX-mode-hook 'flyspell-mode)
; (add-hook 'LaTeX-mode-hook 'flyspell-buffer)
; (add-hook 'org-mode-hook 'flyspell-mode)
; (add-hook 'org-mode-hook 'flyspell-buffer)
(add-hook 'org-mode-hook 'LaTeX-math-mode)

(require 'fix-word)
(global-set-key (kbd "M-u") #'fix-word-upcase)
(global-set-key (kbd "M-l") #'fix-word-downcase)
(global-set-key (kbd "M-c") #'fix-word-capitalize)

(add-hook 'prog-mode-hook 'highlight-indent-guides-mode)
(setq highlight-indent-guides-method 'character)

(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(setq web-mode-markup-indent-offset 2)

;; Smoother and nicer scrolling
;; (setq scroll-margin 10
;;    scroll-step 1
;;    next-line-add-newlines nil
;;    scroll-conservatively 10000
;;    scroll-preserve-screen-position 1)

(setq mouse-wheel-follow-mouse 't)
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1)))

;; Move file to trash instead of removing.
(setq-default delete-by-moving-to-trash t)

(setq
 ;; inhibit-startup-message t         ; Don't show the startup message...
 ;; inhibit-startup-screen t          ; ... or screen
 cursor-in-non-selected-windows t  ; Hide the cursor in inactive windows

 echo-keystrokes 0.1               ; Show keystrokes right away, don't show the message in the scratch buffer
 ;; initial-scratch-message nil       ; Empty scratch buffer
 ;; initial-major-mode 'org-mode      ; Org mode by default
 help-window-select t              ; Select help window so it's easy to quit it with 'q'
 )

;; This is rather radical, but saves from a lot of pain in the ass.
;; When split is automatic, always split windows vertically
(setq split-height-threshold 0)
(setq split-width-threshold nil)

;; (setq inferior-lisp-program (executable-find "sbcl"))

;; (defun sort-lines-by-length (reverse beg end)
;;   "Sort lines by length."
;;   (interactive "P\nr")
;;   (save-excursion
;;     (save-restriction
;;       (narrow-to-region beg end)
;;       (goto-char (point-min))
;;       (let ;; To make `end-of-line' and etc. to ignore fields.
;;           ((inhibit-field-text-motion t))
;;         (sort-subr reverse 'forward-line 'end-of-line nil nil
;;                    (lambda (l1 l2)
;;                      (apply #'< (mapcar (lambda (range) (- (cdr range) (car range)))
;;                                         (list l1 l2)))))))))

(beacon-mode 1)
(setq beacon-push-mark 35)
(setq beacon-color "#666600")


;;; emacs.el
;;
;

;===================================
;; basic setup
;===================================
(set-language-environment "Japanese")
(prefer-coding-system 'utf-8-unix)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-buffer-file-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(setq default-buffer-file-coding-systems 'utf-8)

(setq inhibit-startup-message t)        ; don't show the startup message
(setq kill-whole-line t)                ; C-k deletes the end of line
(setq make-backup-files nil)            ; don't make *~
(setq auto-save-list-file-prefix nil)   ; don't make ~/.saves-PID-hostname
(setq auto-save-default nil)            ; disable auto-saving

(column-number-mode 1)
(menu-bar-mode -1)				        ; don't show menu bar
(setq kill-whole-line t)				; kill whole line  

(setq-default tab-width 4 indent-tabs-mode nil)
(setq c-basic-offset 4)

(transient-mark-mode t)

;===================================
;; load path
;===================================
(add-to-list 'exec-path "/opt/local/bin")
(setq load-path (cons "~/.emacs.d/elisp" load-path))


;; mode
;; tt
(add-hook 'html-helper-load-hook '(lambda () (require 'html-font)))
(autoload 'html-helper-mode "html-helper-mode" "Yay HTML" t)
(require 'html-tt)
(add-hook 'html-helper-mode-hook 'html-tt-load-hook)


;===================================
;; key binding
;===================================
(global-set-key "\C-h" 'backward-delete-char)

;; \C-w 
(defun kill-region-or-backward-kill-word (arg)
  (interactive "p")
  (if mark-active
	  (let ((start (mark))
			(end (point)))
		(kill-region start end))
	(backward-kill-word arg)))
(global-set-key "\C-w" 'kill-region-or-backward-kill-word)

;; 
(define-key ctl-x-map "p" (lambda () (interactive) (other-window -1)))

; browser (w3m)
(setq browse-url-browser-function 'browse-url-generic)
(setq browse-url-generic-program "open")
(global-set-key "\C-xc" 'browse-url-at-point)

;; Dired
(setq dired-load-hook '(lambda () (load "dired-x"))) 
(setq dired-guess-shell-alist-user
      '(("\\.png" "qlmanage -p")
        ("\\.jpg" "qlmanage -p")
        ("\\.pdf" "qlmanage -p")
		)
)

;; grep-find using ack
(add-hook 'dired-load-hook
          '(lambda ()
             (load-library "ls-lisp")
             (setq ls-lisp-dirs-first t)
             (setq dired-listing-switches "-AFl")
             (setq find-ls-option '("-exec ls -AFGl {} \;" . "-AFGl"))
             (setq grep-find-command "ack --nocolor --nogroup ")
             (require 'wdired)
             ))

;; anything
(require 'anything-config)
(setq anything-sources (list anything-c-source-buffers
                             anything-c-source-bookmarks
                             anything-c-source-recentf
                             anything-c-source-recentf
                             anything-c-source-man-pages
                             anything-c-source-locate))
(define-key anything-map (kbd "C-p") 'anything-previous-line)
(define-key anything-map (kbd "C-n") 'anything-next-line)
(define-key anything-map (kbd "C-v") 'anything-next-source)
(define-key anything-map (kbd "M-v") 'anything-previous-source)
(global-set-key (kbd "\C-c;") 'anything)

;===================================
;; color setting
;===================================
(global-font-lock-mode t)  ; always turn on syntax highlighting
(require 'font-lock)       ; Without this line, emacs throws an error on OS X.
(require 'color-theme)
(color-theme-initialize)
(color-theme-dark-laptop)

(global-hl-line-mode)
(set-face-background 'hl-line "SlateBlue4")
(set-face-background 'region "royal blue")
(set-face-foreground 'minibuffer-prompt "cyan1")


;===================================
;; shell stuff
;===================================
(setq comint-buffer-maximum-size 10240) ; set maximum-buffer size for shell-mode
;; don't allow shell prompt to be erased
(setq comint-prompt-read-only "y")
(copy-face 'default 'comint-highlight-prompt)
(set-face-foreground 'comint-highlight-prompt "firebrick1")
(set-face-background 'comint-highlight-prompt "black")

;===================================
;; file binding
;===================================
(setq auto-mode-alist
	  (append '(
				("\\.m$" . objc-mode)
				("\\.mm$" . objc-mode)
				("\\.html$" . html-helper-mode)
				("\\.xhtml$" . html-helper-mode)
				("\\.inc$" . html-helper-mode)
				("\\.tt$" . html-helper-mode)
				("\\.tt2$" . html-helper-mode)
				("\\.wl$" . emacs-lisp-mode)
			   )
	  auto-mode-alist)
)
;===================================
;; C
;===================================
(setq c-hanging-semi&comma-criteria nil)
(add-hook 'c-mode-common-hook
		  '(lambda ()
			 (c-toggle-auto-hungry-state 1)
			 (define-key c-mode-base-map "\C-m" 'newline-and-indent)
             ( c-set-style "stroustrup" )
             ( setq c-basic-offset 4 )
             (flyspell-prog-mode)
		    )
)
(define-key mode-specific-map "c" 'compile)
;===================================
;; Object-c
;===================================
(require 'flymake-objc)
(defun bh-choose-header-mode ()
  (interactive)
  (if (string-equal (substring (buffer-file-name) -2) ".h")
      (progn
        ;; OK, we got a .h file, if a .m file exists we'll assume it's
        ; an objective c file. Otherwise, we'll look for a .cpp file.
        (let ((dot-m-file (concat (substring (buffer-file-name) 0 -1) "m"))
              (dot-cpp-file (concat (substring (buffer-file-name) 0 -1) "cpp")))
          (if (file-exists-p dot-m-file)
              (progn
                (objc-mode)
                )
            (if (file-exists-p dot-cpp-file)
                (c++-mode)
              )
            )
          )
        )
    )
  )
(add-hook 'find-file-hook 'bh-choose-header-mode)

;; compile
(defun iphone-build-simu ()
  (interactive)
  (let ((df (directory-files "."))
        (has-proj-file nil)
        )
    (while (and df (not has-proj-file))
      (let ((fn (car df)))
        (if (> (length fn) 10)
            (if (string-equal (substring fn -10) ".xcodeproj")
                (setq has-proj-file t)
              )
          )
        )
      (setq df (cdr df))
      )
    (if has-proj-file
        (compile "xcodebuild clean install -configuration Debug -sdk iphonesimulator2.2.1")
      (compile "make")
      )
    )
)
(defun iphone-build ()
  (interactive)
  (let (
        (df (directory-files "."))
        (has-proj-file nil)
        )
    (while (and df (not has-proj-file))
      (let ((fn (car df)))
        (if (> (length fn) 10)
            (if 
                (string-equal (substring fn -10) ".xcodeproj")
                (setq has-proj-file t)
              )
          )
        )
      (setq df (cdr df))
      )
    (if has-proj-file
        (compile "xcodebuild clean install -configuration Debug -sdk iphoneos2.2.1")
      (compile "make")
      )
    )
  )

(add-hook 'objc-mode-hook
    (lambda ()
      (setq compile-command
            (set-compile-command-for-objc))
      (define-key objc-mode-map "\C-c\C-c" 'compile)
      )
)
(defun set-compile-command-for-objc ()
  (interactive)
  (let* ((filename (file-name-nondirectory buffer-file-name))
         (index (string-match "\\.m$" filename))
         (filename-no-suffix (substring filename 0 index)))
    (cond
     ;; make用のファイルがあれば "make -k"
     ((or (file-exists-p "Makefile")
          (file-exists-p "makefile"))
      (setq compile-command "make -k"))
     ;; ヘッダファイルがあれば、オブジェクトファイルをつくる
     ((file-exists-p (concat filename-no-suffix ".h"))
      (setq compile-command
            (concat "gcc -ansi -Wall -Os -g -c " filename)))
     ;; Other
     (t
      (setq compile-command
            (concat "gcc -ansi -Wall -Os -g -framework Foundation -o "
                    filename-no-suffix " " filename 
                    "; ./" filename-no-suffix )) ;Run
      )
     )
    )
  )

;;====================================
;; Perl
;====================================
(defalias 'perl-mode 'cperl-mode)
(setq cperl-auto-newline t)
(setq cperl-indent-parens-as-block t)
(setq cperl-close-paren-offset -4)
(setq cperl-indent-level 4)
(setq cperl-label-offset -4)
(setq cperl-continued-statement-offset 4)

(add-hook 'cperl-mode-hook
          (lambda ()
            (set-face-bold-p 'cperl-array-face nil)
			(set-face-foreground 'cperl-array-face "DodgerBlue3")
            (set-face-background 'cperl-array-face "black")
			(set-face-foreground 'cperl-hash-face "DodgerBlue3")
            (set-face-bold-p 'cperl-hash-face nil)
            (set-face-italic-p 'cperl-hash-face nil)
            (set-face-background 'cperl-hash-face "black")
			(setq compile-command
				  (concat "perl " (buffer-file-name)))
			(cperl-define-key "\C-c\C-c" 'compile)
		  )
)

;;====================================
;; PHP
;====================================
;(load-library "php-mode")
;(require 'php-mode)

;;====================================
;; emacs w3m
;====================================
(load "w3m")
(setq w3m-use-cookies t)
(setq w3m-favicon-cache-expire-wait nil)
(setq w3m-search-default-engine "google")

;(setq w3m-home-page "~/.emacs.d/.w3m/bookmark.html")

(define-key w3m-mode-map "r" '(lambda () (interactive) (w3m-next-buffer 1)))
(define-key w3m-mode-map "l" '(lambda () (interactive) (w3m-next-buffer -1)))
(define-key w3m-mode-map "w" 'w3m-delete-buffer)
(define-key w3m-mode-map "i" 'w3m-next-anchor)
(define-key w3m-mode-map "t" 'w3m-view-this-url-new-session)
(define-key w3m-mode-map "'" 'w3m-view-this-url)
(define-key w3m-mode-map "n" 'w3m-toggle-inline-image)
(define-key w3m-mode-map "m" 'w3m-bookmark-view-new-session)


;;====================================
;; psvn
;====================================
(require 'psvn)

;;====================================
;; navi2ch
;====================================

(autoload 'navi2ch "navi2ch" "Navigator for 2ch for Emacs" t)

(setq navi2ch-ask-when-exit nil)
(setq navi2ch-message-user-name "")
(setq navi2ch-net-save-old-file-when-aborn nil)
(setq navi2ch-message-ask-before-send nil)
(setq navi2ch-message-ask-before-kill nil)
(setq navi2ch-article-max-buffers 5)
(setq navi2ch-article-auto-expunge t)
(setq navi2ch-board-insert-subject-with-diff t)
(setq navi2ch-board-insert-subject-with-unread t)
(setq navi2ch-article-exist-message-range '(1 . 1000))
(setq navi2ch-article-new-message-range '(1000 . 1))
(setq navi2ch-list-stay-list-window t)
(global-set-key "\C-c2" 'navi2ch)

;;====================================
;; Wanderlust
;====================================
(load "mime-setup")

(setq ssl-certificate-verification-policy 1) 
(autoload 'wl "wl" "Wanderlust" t)
(autoload 'wl-other-frame "wl" "Wanderlust on new frame." t)
(autoload 'wl-draft "wl" "Write draft with Wanderlust." t)


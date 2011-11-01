;;; emacs.el
;;
;

;===================================
;; basic setup
;===================================
(set-language-environment "Japanese")
;(prefer-coding-system 'utf-8-unix)
;(set-terminal-coding-system 'utf-8)
;(set-keyboard-coding-system 'utf-8)
;(set-buffer-file-coding-system 'utf-8)
;(set-default-coding-systems 'utf-8)
;(setq default-buffer-file-coding-systems 'utf-8)

(setq inhibit-startup-message t)        ; don't show the startup message
(setq kill-whole-line t)                ; C-k deletes the end of line
(setq make-backup-files nil)            ; don't make *~
(setq auto-save-list-file-prefix nil)   ; don't make ~/.saves-PID-hostname
(setq auto-save-default nil)            ; disable auto-saving

(column-number-mode 1)
(menu-bar-mode -1)				        ; don't show menu bar
(setq kill-whole-line t)				; kill whole line  

(setq truncate-partial-width-windows nil) ; 

(setq-default tab-width 4 indent-tabs-mode nil)
(setq c-basic-offset 4)

(transient-mark-mode t)

;; mojibake
(setq auto-coding-functions nil)
;===================================
;; load path
;===================================
;(add-to-list 'exec-path "/opt/local/bin")
(add-to-list 'load-path "~/.emacs.d/elisp")
;(add-to-list 'load-path "~/.emacs.d/elisp/remember")
(add-to-list 'load-path "~/.emacs.d/elisp/tramp")
(add-to-list 'load-path "~/.emacs.d/elisp/wp-emacs")
;(add-to-list 'load-path "~/.emacs.d/elisp/go-mode")
(add-to-list 'load-path "~/.emacs.d/elisp/org-mode")
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

;; controll chrome 
(defun chrome-scroll-next ()
    (interactive)
      (shell-command "/usr/bin/osascript /Users/seiji/bin/chrome_scroll.scpt next"))

(defun chrome-scroll-previous ()
    (interactive)
      (shell-command "/usr/bin/osascript /Users/seiji/bin/chrome_scroll.scpt prev"))

(global-set-key (kbd "C-M-v") 'chrome-scroll-next)
(global-set-key (kbd "M-V") 'chrome-scroll-previous)

;===================================
;; color setting
;===================================
(global-font-lock-mode t)  ; always turn on syntax highlighting
(require 'font-lock)       ; Without this line, emacs throws an error on OS X.
(require 'color-theme)
(color-theme-initialize)
;(color-theme-pok-wob)

(global-hl-line-mode)

(set-face-foreground 'hl-line "white")
(set-face-background 'hl-line "SlateBlue4")
(set-face-background 'region "royal blue")

;; モードライン
;;(set-face-foreground 'modeline "LawnGreen"  )
;(set-face-background 'modeline "SlateBlue4")
;;(set-face-background  'modeline "black")

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
;; install-elisp
;===================================
(require 'install-elisp)
(setq install-elisp-repository-directory "~/.emacs.d/elisp/")


;===================================

;===================================
;; template
;===================================
;; テンプレートの保存先
;; テンプレート挿入時に尋ねない
;; デフォルトは 'function

;===================================
;; C
;===================================
;===================================
;; C#
;===================================

(autoload 'csharp-mode "csharp-mode" "Major mode for editing C# code." t)
(setq auto-mode-alist (cons '("\\.cs$" . csharp-mode) auto-mode-alist))

;; Patterns for finding Microsoft C# compiler error messages:
(require 'compile)
(push '("^\\(.*\\)(\\([0-9]+\\),\\([0-9]+\\)): error" 1 2 3 2) compilation-error-regexp-alist)
(push '("^\\(.*\\)(\\([0-9]+\\),\\([0-9]+\\)): warning" 1 2 3 1) compilation-error-regexp-alist)

;; Patterns for defining blocks to hide/show:
(push '(csharp-mode
        "\\(^\\s *#\\s *region\\b\\)\\|{"
        "\\(^\\s *#\\s *endregion\\b\\)\\|}"
        "/[*/]"
        nil
        hs-c-like-adjust-block-beginning)
            hs-special-modes-alist)
;===================================
;; JavaScript
;===================================
;;; js2-mode
(autoload 'js2-mode "js2" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))

; fixing indentation
; refer to http://mihai.bazon.net/projects/editing-javascript-with-emacs-js2-mode
(autoload 'espresso-mode "espresso")
(defun my-js2-indent-function ()
  (interactive)
  (save-restriction
    (widen)
    (let* ((inhibit-point-motion-hooks t)
           (parse-status (save-excursion (syntax-ppss (point-at-bol))))
           (offset (- (current-column) (current-indentation)))
           (indentation (espresso--proper-indentation parse-status))
           node)
      (save-excursion
        ;; I like to indent case and labels to half of the tab width
        (back-to-indentation)
        (if (looking-at "case\\s-")
            (setq indentation (+ indentation (/ espresso-indent-level 2))))
        
        ;; consecutive declarations in a var statement are nice if
        ;; properly aligned, i.e:
        ;;
        ;; var foo = "bar",
        ;;     bar = "foo";
        (setq node (js2-node-at-point))
        (when (and node
                   (= js2-NAME (js2-node-type node))
                   (= js2-VAR (js2-node-type (js2-node-parent node))))
          (setq indentation (+ 4 indentation))))
      (indent-line-to indentation)
      (when (> offset 0) (forward-char offset)))))

(defun my-indent-sexp ()
  (interactive)
  (save-restriction
    (save-excursion
      (widen)
      (let* ((inhibit-point-motion-hooks t)
             (parse-status (syntax-ppss (point)))
             (beg (nth 1 parse-status))
             (end-marker (make-marker))
             (end (progn (goto-char beg) (forward-list) (point)))
             (ovl (make-overlay beg end)))
        (set-marker end-marker end)
        (overlay-put ovl 'face 'highlight)
        (goto-char beg)
        (while (< (point) (marker-position end-marker))
          ;; don't reindent blank lines so we don't set the "buffer
          ;; modified" property for nothing
          (beginning-of-line)
          (unless (looking-at "\\s-*$")
            (indent-according-to-mode))
          (forward-line))
        (run-with-timer 0.5 nil '(lambda(ovl)
                                   (delete-overlay ovl)) ovl)))))
(defun my-js2-mode-hook ()
  (require 'espresso)
  (setq espresso-indent-level 4
        indent-tabs-mode nil
        c-basic-offset 4)
  (c-toggle-auto-state 0)
  (c-toggle-hungry-state 1)
  (set (make-local-variable 'indent-line-function) 'my-js2-indent-function)
                                        ; (define-key js2-mode-map [(meta control |)] 'cperl-lineup)
  (define-key js2-mode-map "\C-\M-\\"
    '(lambda()
       (interactive)
       (insert "/* -----[ ")
       (save-excursion
         (insert " ]----- */"))
       ))
  (define-key js2-mode-map "\C-m" 'newline-and-indent)
                                        ; (define-key js2-mode-map [(backspace)] 'c-electric-backspace)
                                        ; (define-key js2-mode-map [(control d)] 'c-electric-delete-forward)
  (define-key js2-mode-map "\C-\M-q" 'my-indent-sexp)
  (if (featurep 'js2-highlight-vars)
      (js2-highlight-vars-mode))
  (message "My JS2 hook"))
(add-hook 'js2-mode-hook 'my-js2-mode-hook)
;===================================
;; UnityJS
;===================================
;; UnityJS mode for emacs
;;(autoload 'unityjs-mode "unityjs-mode" "Major mode for editing Unity Javascript code." t)
;;(require 'unityjs-mode)

;===================================
;; Object-c
;===================================

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
;; Ruby
;====================================
(require 'rvm)
(rvm-use-default)
(add-hook 'ruby-mode-hook
          (lambda ()
            ;; (set-face-bold-p 'cperl-array-face nil)
			;; (set-face-foreground 'cperl-array-face "DodgerBlue3")
            ;; (set-face-background 'cperl-array-face "black")
			;; (set-face-foreground 'cperl-hash-face "DodgerBlue3")
            ;; (set-face-bold-p 'cperl-hash-face nil)
            ;; (set-face-italic-p 'cperl-hash-face nil)
            ;; (set-face-background 'cperl-hash-face "black")
			(setq compile-command
				  (concat "ruby " (buffer-file-name)))
			(define-key ruby-mode-map (kbd "\C-c\C-c") 'compile)
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
;; (load "w3m")
;; (setq w3m-use-cookies t)
;; (setq w3m-favicon-cache-expire-wait nil)
;; (setq w3m-search-default-engine "google")

;; ;(setq w3m-home-page "~/.emacs.d/.w3m/bookmark.html")

;; (define-key w3m-mode-map "r" '(lambda () (interactive) (w3m-next-buffer 1)))
;; (define-key w3m-mode-map "l" '(lambda () (interactive) (w3m-next-buffer -1)))
;; (define-key w3m-mode-map "w" 'w3m-delete-buffer)
;; (define-key w3m-mode-map "i" 'w3m-next-anchor)
;; (define-key w3m-mode-map "t" 'w3m-view-this-url-new-session)
;; (define-key w3m-mode-map "'" 'w3m-view-this-url)
;; (define-key w3m-mode-map "n" 'w3m-toggle-inline-image)
;; (define-key w3m-mode-map "m" 'w3m-bookmark-view-new-session)


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

;;====================================
;; Wanderlust
;====================================
;; (load "mime-setup")

;; (setq ssl-certificate-verification-policy 1) 
;; (autoload 'wl "wl" "Wanderlust" t)
;; (autoload 'wl-other-frame "wl" "Wanderlust on new frame." t)
;; (autoload 'wl-draft "wl" "Write draft with Wanderlust." t)


;;====================================
;; Tramp
;====================================
;(require 'tramp)
;(setq tramp-default-method "ssh")

;(add-to-list 'tramp-default-proxies-alist '("picto" nil "/ssh:root@ldg:"))
; ldg
;(add-to-list 'tramp-default-proxies-alist '("ldg" nil "/sudo:ldl:"))
; ldl
;(add-to-list 'tramp-default-proxies-alist '("ldl" "root" "/ssh:seiji@ldl:"))

;(setq tramp-debug-buffer t)
;(setq tramp-shell-prompt-pattern "^.*[#＼$%>] *")
;(setq tramp-verbose 10)
;(setq vc-handled-backends nil)
;(setq ls-lisp-use-insert-directory-program t)     
;

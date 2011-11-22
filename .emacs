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
(add-to-list 'load-path "~/.emacs.d/elisp/org-mode")
;(add-to-list 'load-path "~/.emacs.d/elisp/remember")
(add-to-list 'load-path "~/.emacs.d/elisp/tramp")
(add-to-list 'load-path "~/.emacs.d/elisp/wp-emacs")
;(add-to-list 'load-path "~/.emacs.d/elisp/go-mode")
(add-to-list 'load-path "~/.emacs.d/elisp/navi2ch")
(add-to-list 'load-path "~/.emacs.d/elisp/auto-complete")

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

;; etags
(global-set-key (kbd "M-g .")   'find-tag-regexp)
(global-set-key (kbd "C-M-.")   'find-tag-next)
(global-set-key (kbd "M-,")     'find-tag-other-window)
(defun list-tags-currentbuf ()
  "List the tags for the current buffer."
  (interactive)
  (list-tags (buffer-file-name)))
(global-set-key (kbd "M-/")     'list-tags-currentbuf)

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
(require 'anything-gist)
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
(global-set-key (kbd "\C-x;") 'anything)

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
(load "moccur-edit")
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
;; hideshow.el (std)
;===================================
;;   
;;   hs-hide-block                      C-c @ C-h
;;   hs-show-block                      C-c @ C-s
;;   hs-hide-all                        C-c @ C-M-h
;;   hs-show-all                        C-c @ C-M-s
;;   hs-hide-level                      C-c @ C-l
;;   hs-toggle-hiding                   C-c @ C-c
;;   hs-mouse-toggle-hiding             [(shift mouse-2)]
;;   hs-hide-initial-comment-block
;;

;===================================
;; auto-complete
;===================================
;(require 'auto-complete)
(require 'auto-complete-config)
(require 'auto-complete-clang)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/elisp/auto-complete/dict")

(setq ac-auto-start nil)
(setq ac-quick-help-delay 0.5)
(define-key ac-mode-map  [(control tab)] 'auto-complete)

(defun my-ac-cc-mode-setup ()
  ;; 読み込むプリコンパイル済みヘッダ
  (setq ac-clang-prefix-header "~/.emacs.d/elisp/auto-complete/stdafx.pch")
  ;; 補完を自動で開始しない
  (setq ac-clang-flags '("-w" "-ferror-limit" "1"))
  (setq ac-sources (append '(ac-source-clang
                             ac-source-yasnippet
                             ac-source-gtags)
                           ac-sources))
  )
(defun my-ac-objc-mode-setup ()
  ;; 読み込むプリコンパイル済みヘッダ
  (setq ac-clang-prefix-header nil)
;;  (setq ac-clang-flags '("-Wall" "-Wextra" "-ObjC" "-std=c99" "-isysroot" "/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator4.0.sdk" "-I."  "-D__IPHONE_OS_VERSION_MIN_tREQUIR;;ED=30200"))
  (setq ac-clang-flags '("-Wall" "-Wextra" "-std=c99" "-isysroot" "/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator4.0.sdk" "-I."  "-D__IPHONE_OS_VERSION_MIN_tREQUIR;;ED=30200"))
  (setq ac-sources (append '(ac-source-clang
                             ac-source-yasnippet
                             ac-source-gtags)
                           ac-sources))
  )

;; (defun my-ac-config ()
;;   (global-set-key "\M-/" 'ac-start)
;;   ;; C-n/C-p で候補を選択
;;   (define-key ac-complete-mode-map "\C-n" 'ac-next)
;;   (define-key ac-complete-mode-map "\C-p" 'ac-previous)
;;   (add-hook 'emacs-lisp-mode-hook 'ac-emacs-lisp-mode-setup)
;;   (add-hook 'auto-complete-mode-hook 'ac-common-setup)
;;   (add-hook 'c-mode-common-hook 'my-ac-cc-mode-setup)
;;   (add-hook 'objc-mode-hook 'my-ac-objc-mode-setup )
;;   (global-auto-complete-mode t)
;;   )

;; (add-to-list 'ac-modes 'objc-mode) ;
;; (my-ac-config)

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
(add-hook 'csharp-mode-hook
          (c-set-offset 'substatement-open 0)
          )
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
;; (autoload 'unityjs-mode "unityjs-mode" "Major mode for editing Unity Javascript code." t)
;; (require 'unityjs-mode)

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
;; twittering mode
;====================================
(require 'twittering-mode)
(setq twittering-username "seijit")
(setq twittering-password "sunset")
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
(load "mime-setup")

(setq ssl-certificate-verification-policy 1) 
(autoload 'wl "wl" "Wanderlust" t)
(autoload 'wl-other-frame "wl" "Wanderlust on new frame." t)
(autoload 'wl-draft "wl" "Write draft with Wanderlust." t)

;;(require 'elmo-search-est)

;;====================================
;; Org-Mode
;====================================
(require 'org-install)
(setq org-startup-truncated nil)
(setq org-return-follows-link t)
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(org-remember-insinuate)
(setq org-directory "~/memo/")
(setq org-default-notes-file (concat org-directory "agenda.org"))
(setq org-remember-templates
      '(("Todo" ?t "** TODO %?\n   %i\n   %a\n   %t" nil "Inbox")
        ("Bug" ?b "** TODO %?   :bug:\n   %i\n   %a\n   %t" nil "Inbox")
        ("Idea" ?i "** %?\n   %i\n   %a\n   %t" nil "New Ideas")
        ))
(require 'org-html5presentation)
;;====================================
;; Tramp
;====================================
(require 'tramp)
(setq tramp-default-method "ssh")

(add-to-list 'tramp-default-proxies-alist '("dev-mobile.livedoor.com" nil "/ssh:root@ldg:"))
(add-to-list 'tramp-default-proxies-alist '("10.0.211.220" nil "/ssh:root@ldg:"))

;; NG incase BSD
;; PC
(add-to-list 'tramp-default-proxies-alist '("dev01.news-ng" nil "/ssh:root@ldg:"))

;; mobile
; ldg -> dev-mobile
(add-to-list 'tramp-default-proxies-alist '("10.0.214.158" nil "/ssh:root@ldg:"))
; ldg -> dev-mobile2
(add-to-list 'tramp-default-proxies-alist '("10.0.213.47" nil "/ssh:root@ldg:"))
; ldg -> m_admin batch
(add-to-list 'tramp-default-proxies-alist '("10.0.207.235" nil "/ssh:root@ldg:"))
;; top
; ldg -> top.dev
(add-to-list 'tramp-default-proxies-alist '("10.0.213.114" nil "/ssh:root@ldg:"))
;; news
; ldg -> dev01.news-ng
(add-to-list 'tramp-default-proxies-alist '("10.0.205.48" nil "/ssh:root@ldg:"))
; ldg -> dev101.news-ng
(add-to-list 'tramp-default-proxies-alist '("10.130.61.53" nil "/ssh:root@ldg:"))

; ldg -> www115.news.xen
(add-to-list 'tramp-default-proxies-alist '("10.130.72.65" nil "/ssh:root@ldg:"))

; ldg -> music.dev
(add-to-list 'tramp-default-proxies-alist '("10.0.204.124" nil "/ssh:root@ldg:"))

; ldg -> dev17 movie-enter maverick.dev
(add-to-list 'tramp-default-proxies-alist '("10.0.210.189" nil "/ssh:root@ldg:"))
; ldg -> dev19 anigema
(add-to-list 'tramp-default-proxies-alist '("10.0.208.69" nil "/ssh:root@ldg:"))

; ldg -> dev-pcpf 10.0.212.91
(add-to-list 'tramp-default-proxies-alist '("10.0.212.91" nil "/ssh:root@ldg:"))
; ldg -> dev-karame
(add-to-list 'tramp-default-proxies-alist '("10.0.211.220" nil "/ssh:root@ldg:"))
; ldg -> dev-karame
(add-to-list 'tramp-default-proxies-alist '("10.130.61.61" nil "/ssh:root@ldg:"))


; ldg -> dcmee
(add-to-list 'tramp-default-proxies-alist '("10.0.212.50" nil "/ssh:root@ldg:"))

; ldg -> ugo
(add-to-list 'tramp-default-proxies-alist '("10.0.204.54" nil "/ssh:root@ldg:"))


; ldl -> phoenix
(add-to-list 'tramp-default-proxies-alist '("adt" nil "/ssh:seiji@ldl:"))
; ldl -> decoking
(add-to-list 'tramp-default-proxies-alist '("deco" "toyama" "/ssh:seiji@ldl:"))

; picto -> dev
;(add-to-list 'tramp-default-proxies-alist '("192.168.20.232" nil "/sudo:picto:"))
(add-to-list 'tramp-default-proxies-alist '("192.168.20.232" nil "/ssh:root@picto:"))

; ldl -> picto
;(add-to-list 'tramp-default-proxies-alist '("picto" "root" "/ssh:toyama@picto:"))
(add-to-list 'tramp-default-proxies-alist '("picto" nil "/ssh:root@ldg:"))

; ldg
(add-to-list 'tramp-default-proxies-alist '("ldg" nil "/sudo:ldl:"))

; ldl
(add-to-list 'tramp-default-proxies-alist '("ldl" "root" "/ssh:seiji@ldl:"))

;(setf tramp-shell-prompt-pattern "^[^#$>n]*[#$%>] *(0-9;]*[a-zA-Z] *)*")
;(setq shell-prompt-pattern "^[ $%]+")
;(setq tramp-shell-prompt-pattern "^.*[#$%>] *")
(setq tramp-debug-buffer t)
(setq tramp-shell-prompt-pattern "^.*[#＼$%>] *")
(setq tramp-verbose 10)
(setq vc-handled-backends nil)
(setq ls-lisp-use-insert-directory-program t)     
;
;====================================;
; wp-emacs
;====================================
(require 'weblogger)

(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(weblogger-config-alist (quote (("default" ("user" . "seiji") ("pass" . "sunset" ) ("server-url" . "http://blog.seiji.me/xmlrpc.php") ("weblog" . "1"))))))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )
(global-set-key "\C-c\C-w" 'weblogger-start-entry)  ; weblogger起動（C-c C-w）

(defun my-weblogger-send-entry (&optional arg)
  (interactive)
  (save-buffer)
  (set-buffer-modified-p t)
  (weblogger-save-entry nil arg)
  (my-weblogger-quit))

(defun my-weblogger-quit ()
  (interactive)
  (when (y-or-n-p "Do you want to quit weblogger-entry? ")
    (bury-buffer)))

(add-hook 'weblogger-start-edit-entry-hook
          '(lambda ()
            (insert-file "~/.emacs.d/template/template.html")
             (define-key weblogger-entry-mode-map (kbd "C-x C-s") nil)
             (define-key weblogger-entry-mode-map (kbd "C-c n")   'weblogger-next-entry)
             (define-key weblogger-entry-mode-map (kbd "C-c p")   'weblogger-prev-entry)
             (define-key weblogger-entry-mode-map (kbd "C-c c")   'weblogger-start-entry)
             (define-key weblogger-entry-mode-map (kbd "C-c C-c") 'my-weblogger-send-entry)
             (define-key weblogger-entry-mode-map (kbd "C-c C-k") 'my-weblogger-quit)
             (zencoding-mode t)                     ; zencoding-mode
             (yas/minor-mode t)                     ; YASnippet マイナーモードを有効
             (auto-fill-mode -1)))                  ; 自動改行をOFF

;; Go mode(require 'go-mode-load)


;;; This was installed by package-install.el.
;;; This provides support for the package system and
;;; interfacing with ELPA, the package archive.
;;; Move this code earlier if you want to reference
;;; packages in your .emacs.
(when
    (load
     (expand-file-name "~/.emacs.d/elpa/package.el"))
  (package-initialize))

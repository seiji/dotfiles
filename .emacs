;;; emacs.el
;;
;;

;===================================
;; basic setup
;===================================

;; basic setup
;(set-language-environment "Japanese")
;(set-default-coding-systems 'utf-8)
;(set-keyboard-coding-system 'utf-8)
;(set-terminal-coding-system 'utf-8)

(setq inhibit-startup-message t)        ; don't show the startup message
(setq kill-whole-line t)                ; C-k deletes the end of line
(setq make-backup-files nil)            ; don't make *~
(setq auto-save-list-file-prefix nil)   ; don't make ~/.saves-PID-hostname
(setq auto-save-default nil)            ; disable auto-saving
(column-number-mode 1)

(setq-default tab-width 4)
(setq c-basic-offset 4)

;
; key binding
;

(global-set-key "\C-h" 'backward-delete-char)
(global-set-key "\C-w" 'backward-kill-word)
(define-key minibuffer-local-completion-map "\C-w" 'backward-kill-word)
(transient-mark-mode t)
(define-key ctl-x-map "p" (lambda () (interactive) (other-window -1)))

(menu-bar-mode -1)				        ; don't show menu bar
(setq kill-whole-line t)				; kill whole line  

;===================================
;; color setting
;===================================
(global-font-lock-mode t)  ; always turn on syntax highlighting
(require 'font-lock) ; Without this line, emacs throws an error on OS X.

(set-face-foreground 'region "white")
(set-face-background 'region "royal blue")
(set-face-foreground 'minibuffer-prompt "cyan1")

;===================================
;; shell stuff
;===================================
;; set maximum-buffer size for shell-mode
(setq comint-buffer-maximum-size 10240)
;; don't allow shell prompt to be erased
(setq comint-prompt-read-only "y")
(copy-face 'default 'comint-highlight-prompt)
(set-face-foreground 'comint-highlight-prompt "firebrick1")
(set-face-background 'comint-highlight-prompt "black")

;===================================
;; load path
;===================================
(setq load-path (cons "~/.emacs.d/elisp" load-path))


;===================================
;; install-elisp
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
))


;;====================================
;; PHP
;====================================
(load-library "php-mode")
(require 'php-mode)

;;====================================
;; emacs w3m
;====================================
(load "w3m")
(setq w3m-use-cookies t)
(setq w3m-favicon-cache-expire-wait nil)
; タブを移動する
(define-key w3m-mode-map "l" '(lambda () (interactive) (w3m-next-buffer 1)))
(define-key w3m-mode-map "h" '(lambda () (interactive) (w3m-next-buffer -1)))
; タブを閉じる
(define-key w3m-mode-map "o" 'w3m-delete-buffer)
; 次のリンクに飛ぶ
(define-key w3m-mode-map "i" 'w3m-next-anchor)
; リンクを新しいタブで開く
(define-key w3m-mode-map ";" 'w3m-view-this-url-new-session)
; リンクを普通に開く
(define-key w3m-mode-map "'" 'w3m-view-this-url)
; カーソル下にある画像を表示
(define-key w3m-mode-map "n" 'w3m-toggle-inline-image)
; ブックマークを表示
(define-key w3m-mode-map "m" 'w3m-bookmark-view-new-session)

;;====================================
;; psvn
;====================================
(require 'psvn)

;;====================================
;; shell-mode
;====================================
;;; shell-mode でエスケープを綺麗に表示
;(autoload 'ansi-color-for-comint-mode-on "ansi-color"
;     "Set `ansi-color-for-comint-mode' to t." t)
;(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)
;;; shell-modeで上下でヒストリ補完
;(add-hook 'shell-mode-hook
;		     (function (lambda ()
;						       (define-key shell-mode-map [up] 'comint-previous-input)
;							         (define-key shell-mode-map [down] 'comint-next-input))))

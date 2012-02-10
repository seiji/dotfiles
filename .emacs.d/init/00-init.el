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

;; display
(menu-bar-mode -1)                                      ; don't show menu bar
(setq kill-whole-line t)                                ; kill whole line
(setq truncate-partial-width-windows nil) ;

(line-number-mode 1)
(column-number-mode 1)
(show-paren-mode 1) 
(transient-mark-mode t)

(setq-default tab-width 4 indent-tabs-mode nil)
;(setq-default tab-width 4 indent-tabs-mode t)
(setq c-basic-offset 4)

(fset 'yes-or-no-p 'y-or-n-p)
;; mojibake
(setq auto-coding-functions nil)

;; hilight 
(global-hl-line-mode 1)
(set-face-foreground 'hl-line "white")
(set-face-background 'hl-line "SlateBlue4")
(set-face-background 'region "royal blue")

;; history
(savehist-mode 1)
(setq-default save-place t)
(require 'saveplace)

;; GC
(setq gc-cons-threshold (* 10 gc-cons-threshold)) 

(ffap-bindings)








;;; emacs.el
;;
;;

;===================================
;; basic setup
;===================================

;; basic setup
(setq inhibit-startup-message t)        ; don't show the startup message
(setq kill-whole-line t)                ; C-k deletes the end of line
(setq make-backup-files nil)            ; don't make *~
(setq auto-save-list-file-prefix nil)   ; don't make ~/.saves-PID-hostname
(setq auto-save-default nil)            ; disable auto-saving
(column-number-mode 1)

(setq-default tab-width 4)
(setq c-basic-offset 4)

;===================================
;; load path
;===================================
(setq load-path (cons "~/.emacs.d/elisp" load-path))

;===================================
;; install-elisp
;===================================
(require 'install-elisp)
(setq install-elisp-repository-directory "~/.emacs.d/elisp/")

;;====================================
;;display line number 
;====================================
(autoload 'setnu-mode "setnu" nil t)
(global-set-key [f12] 'setnu-mode)

;;; emacs.el ends here.


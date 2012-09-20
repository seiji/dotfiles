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
(setq auto-coding-functions nil)        ; mojibake

(setq inhibit-startup-message t)        ; don't show the startup message
(setq kill-whole-line t)                ; C-k deletes the end of line
(setq make-backup-files nil)            ; don't make *~
(setq auto-save-list-file-prefix nil)   ; don't make ~/.saves-PID-hostname
(setq auto-save-default nil)            ; disable auto-saving

(fset 'yes-or-no-p 'y-or-n-p)

(put 'set-goal-column 'disabled nil)

;; Filename Japanese
(when (eq system-type 'darwin)
  (require  'ucs-normalize)
  (set-file-name-coding-system 'utf-8-hfs)
  (setq  locale-coding-system 'utf-8-hfs))


;;; Modeline
(line-number-mode t)
(column-number-mode t)
;(size-indication-mode t)

;; display
(menu-bar-mode -1)                                      ; don't show menu bar
(setq kill-whole-line t)                                ; kill whole line
(setq truncate-partial-width-windows nil) ;

(transient-mark-mode t)

;; style
(setq-default tab-width 4 indent-tabs-mode nil)
;(setq-default tab-width 4 indent-tabs-mode t)
(setq c-basic-offset 4)

;; hilight
(global-hl-line-mode t)

(set-face-foreground 'hl-line "white")
(set-face-background 'hl-line "SlateBlue4") 
(set-face-background 'region "royal blue")

;; paren
(setq show-paren-delay 0)
(show-paren-mode t)

;; history
(savehist-mode 1)
(setq-default save-place t)
(require 'saveplace)

;; GC
(setq gc-cons-threshold (* 10 gc-cons-threshold)) 

(ffap-bindings)
;;Remove Buffer $buffer still has clients; kill it?
(remove-hook 'kill-buffer-query-functions 'server-kill-buffer-query-function)

;; clipboard
(defun copy-from-osx ()
  (shell-command-to-string "pbpaste"))

(defun paste-to-osx (text &optional push)
  (let ((process-connection-type nil))
    (let ((proc (start-process "pbcopy" "*Messages*" "pbcopy")))
      (process-send-string proc text)
      (process-send-eof proc))))

(setq interprogram-cut-function 'paste-to-osx)
(setq interprogram-paste-function 'copy-from-osx)

(defun insert-datetime ()
  (interactive)
  (insert (format-time-string "%Y-%m-%d %H:%M:%SZ" nil "Z")))

;; Dired
;; Reveal in Finder
(defun my-dired-do-reveal (&optional arg)
  "Reveal the marked files in Finder.
If no files are marked or a specific numeric prefix arg is given,
the next ARG files are used.  Just \\[universal-argument] means the current file."
  (interactive "P")
  (let ((files (dired-get-marked-files nil arg))
        (script
         (concat
          "on run argv\n"
          "    set itemArray to {}\n"
          "    repeat with i in argv\n"
          "        set itemArray to itemArray & (i as POSIX file as Unicode text)\n"
          "    end repeat\n"
          "    tell application \"Path Finder\"\n"
                                        ;"    tell application \"Finder\"\n"
          "        activate\n"
          "        reveal itemArray\n"
          "    end tell\n"
          "end run\n")))
    (apply 'start-process "osascript-reveal" nil "osascript" "-e" script files)))

(eval-after-load "dired"
    '(define-key dired-mode-map "\M-r" 'my-dired-do-reveal)) ; move-to-window-line

(defun js-json-reformat (beg end)
    (interactive "r")
      (shell-command-on-region beg end "python -m json.tool" nil t))

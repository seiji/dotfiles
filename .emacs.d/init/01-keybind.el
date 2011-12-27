(require 'sticky)
(use-sticky-key ";" sticky-alist:en)
;===================================
;; key binding
;===================================
;(global-set-key "\C-h" 'backward-delete-char)
(global-set-key "\C-h" 'delete-backward-char)

(setq next-line-add-newlines t)

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

; controll chrome
(defun chrome-scroll-next ()
      (interactive)
            (shell-command "/usr/bin/osascript /Users/seiji/bin/chrome_scroll.scpt next"))

(defun chrome-scroll-previous ()
      (interactive)
            (shell-command "/usr/bin/osascript /Users/seiji/bin/chrome_scroll.scpt prev"))

(global-set-key (kbd "C-M-v") 'chrome-scroll-next)
(global-set-key (kbd "M-V") 'chrome-scroll-previous)

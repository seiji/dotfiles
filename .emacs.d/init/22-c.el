(defun c-begin-comment-box ()
  "Insert the beginning of a comment, followed by a string of asterisks."
  (interactive)
  (insert "/************************************************\n"))

(defun c-end-comment-box ()
  "Insert a string of asterisks, followed by the end of a comment."
  (interactive)
  (insert "************************************************/\n"))

(add-hook 'c-mode-hook
          '(lambda ()
             (define-key c-mode-map "\C-cb" 'c-begin-comment-box)
             (define-key c-mode-map "\C-ce" 'c-end-comment-box)))








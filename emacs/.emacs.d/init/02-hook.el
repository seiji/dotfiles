;;; 02-hook.el ---
(defun elisp-mode-hooks()
  "lisp-mode-hooks"
  (when (require 'eldoc nil t)
    (setq eldoc-idle-delay 0.2)
    (setq eldoc-echo-area-use-multiline-p t)
    (turn-on-eldoc-mode)))
  
(add-hook 'emacs-lisp-mode-hook 'elisp-mode-hooks)

;;start  #! -> save +x
(add-hook 'after-save-hook
          'executable-make-buffer-file-executable-if-script-p)






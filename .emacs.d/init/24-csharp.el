;(require 'csharp-mode)
(setq auto-mode-alist
      (append '(("\\.cs$" . csharp-mode)) auto-mode-alist))
(add-hook 'csharp-mode-hook
          '(lambda ()
             (setq compile-command
                   (concat "mcs " (buffer-file-name) " && mono " 
                           (replace-regexp-in-string "\.cs$" ".exe"
                                                     (buffer-file-name (current-buffer)))))
             (define-key csharp-mode-map "\C-c\C-c" 'compile)
			 (c-set-offset 'substatement-open 0)
			 (c-set-offset 'case-label '+)
			 (c-set-offset 'arglist-intro '+)
			 (c-set-offset 'arglist-close 0)
			 (hs-minor-mode)
))
(push '(csharp-mode
		"\\(^\\s *#\\s *region\\b\\)\\|{"
		"\\(^\\s *#\\s *endregion\\b\\)\\|}"
		"/[*/]"
		nil
		hs-c-like-adjust-block-beginning)
	  hs-special-modes-alist)




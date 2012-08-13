;; twittering-mode
;(setq twittering-status-format "%C{%Y/%m/%d %H:%M:%S} %s > %t // from %f%L")
(setq twittering-status-format "%s %R %FILL{  %T  } \n ")
;(setq twittering-status-format "%C{%b %d %H:%M:%S} %s %FILL{ %T  }")
;(setq twittering-status-format "%s %R \n %FILL{%t} \n")
(setq twittering-timer-interval 36000000)
(setq twittering-use-master-password t)

(setq twittering-initial-timeline-spec-string
	  '(":home"
		":mentions"
		":replies"
        "seijit/reading"
		))
(setq twittering-toggle-activate-buffer nil)
(setq twittering-scroll-mode t)
(defun twittering-mode-hook-func ()
  (set-face-bold-p 'twittering-username-face t)
  (set-face-foreground 'twittering-username-face "DeepSkyBlue3")
  (set-face-foreground 'twittering-uri-face "ForestGreen")
										;  (set-face-foreground 'twittering-username-face "White")
										;  (set-face-foreground 'twittering-uri-face "gray35")
  )

(add-hook 'twittering-mode-hook 'twittering-mode-hook-func)

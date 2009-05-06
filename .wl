; 日本語フォルダ対策
(setq elmo-imap4-use-modified-utf7 t)

(require 'mime-w3m)
(setq mime-w3m-display-inline-images t)

; SMTPサーバー
;; (setq wl-smtp-connection-type 'starttls)
;; (setq wl-smtp-posting-port 587)
;; (setq wl-smtp-authenticate-type "plain")
;; (setq wl-smtp-posting-user "sebraincom")
;; (setq wl-smtp-posting-server "smtp.gmail.com")
;; (setq wl-local-domain "gmail.com")
;; (setq wl-from "Seiji Toyama <sebraincom@gmail.com>")

;; template
(setq wl-template-alist
      '(
		("default"
         ("From" . "seijit@me.com")
         (body-file . "~/.signature")
		)

;;         ("report"
;;          (template . "default")                 
;;          ("To" . "jousi@example.com")
;;          ("Subject" . "報告")
;;          (body-file . "~/work/report.txt")
;;          )

       )
)

;; config
(setq wl-draft-config-alist
      '(
	  ("^From: .*seijit@i.softbank.jp"
         (wl-smtp-connection-type . nil)
         (wl-envelope-from . "seijit@i.softbank.jp")
         (wl-from . "seijit@i.softbank.jp <seijit@i.softbank.jp>")
         (wl-smtp-posting-user . "seijit")
         (wl-smtp-posting-server . "smtp.softbank.jp")
         (wl-local-domain . "i.softbank.jp") 
         (wl-fcc . "%Sent Messages")
         (wl-fcc-force-as-read . t)
	  )
	  ("^From: .*sebraincom@gmail.com"
		 (wl-smtp-connection-type . 'starttls)
		 (wl-smtp-posting-port . 587)
		 (wl-smtp-authenticate-type . "plain")
		 (wl-smtp-posting-user . "sebraincom@gmail.com")
	     (wl-smtp-posting-server . "smtp.gmail.com")
		 (wl-local-domain . "gmail.com")
		 (wl-envelope-from . "sebraincom@gmail.com")
	  )		 
	  ("^From: .*seijit@me.com"
		 (wl-smtp-connection-type . 'starttls)
		 (wl-smtp-posting-port . 587)
		 (wl-smtp-authenticate-type . "plain")
		 (wl-smtp-posting-user . "seijit@me.com")
	     (wl-smtp-posting-server . "smtp.me.com")
		 (wl-local-domain . "me.com")
		 (wl-envelope-from . "seijit@me.com")
	  )		 
))

;; key binding
(defun st-wl-summary-refile-spam ()
  (interactive)
  (wl-summary-refile (wl-summary-message-number) "%[Gmail]/Spam")
  (wl-summary-next))
(define-key wl-summary-mode-map "!" 'st-wl-summary-refile-spam)
(define-key wl-summary-mode-map "\M-u" 'wl-summary-mark-as-unread)

(setq wl-folder-check-async t) ; 非同期でチェックするように

(setq wl-dispose-folder-alist
      (cons '("^%inbox" . remove) wl-dispose-folder-alist))

;; 3ペイン表示
(setq wl-stay-folder-window t 
      wl-folder-window-width 30)
(setq smtp-end-of-line "\n")

;; 
(setq signature-insert-at-eof t)

(add-hook 'wl-mail-setup-hook
   (lambda ()
   (unless wl-draft-reedit ; 再編集時は適用しない
   (let (wl-template-visible-select)
   (wl-template-select))))
)
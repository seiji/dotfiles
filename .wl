;;; .wl
;;
;

; 日本語フォルダ対策
(setq elmo-imap4-use-modified-utf7 t)

(require 'mime-w3m)
;;(setq mime-w3m-display-inline-images t)

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
;; (defun st-wl-summary-refile-spam ()
;;   (interactive)
;;   (wl-summary-refile (wl-summary-message-number) "%[Gmail]/Spam")
;;   (wl-summary-next))
;; (define-key wl-summary-mode-map "!" 'st-wl-summary-refile-spam)
;; (define-key wl-summary-mode-map "\M-u" 'wl-summary-mark-as-unread)


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

;;;------------------------------------------
;; summary-mode ですべての header を一旦除去
;; (setq mime-view-ignored-field-list '("^.*"))

;; ;; 表示するヘッダ。
;; (setq wl-message-visible-field-list
;;       (append mime-view-visible-field-list
;;         '("^Subject:" "^From:" "^To:" "^Cc:" 
;;           "^X-Mailer:" "^X-Newsreader:" "^User-Agent:"
;;           "^X-Face:" "^X-Mail-Count:" "^X-ML-COUNT:" "^Mailing-List:"
;;           )))

;; ;; 隠すメールヘッダを指定。
;; (setq wl-message-ignored-field-list
;;       (append mime-view-ignored-field-list
;;       '(".*Received:" ".*Path:" ".*Id:" "^References:"
;;         "^Replied:" "^Errors-To:"
;;         "^Lines:" "^Sender:" ".*Host:" "^Xref:"
;;         "^Content-Type:" "^Content-Transfer-Encoding:"
;;         "^Precedence:"
;;         "^Status:" "^X-VM-.*:"
;;         "^X-Info:" "^X-PGP" "^X-Face-Version:"
;;         "^X-UIDL:" "^X-Dispatcher:"
;;         "^MIME-Version:" "^X-ML" "^Message-I.:"
;;         "^Delivered-To:" "^Mailing-List:"
;;         "^ML-Name:" "^Reply-To:" "Date:"
;;         "^X-Loop" "^X-List-Help:"
;;         "^X-Trace:" "^X-Complaints-To:"
;;         "^Received-SPF:" "^Message-ID:"
;;         "^MIME-Version:" "^Content-Transfer-Encoding:"
;;         "^Authentication-Results:"
;;         "^X-Priority:" "^X-MSMail-Priority:"
;;         "^X-Mailer:" "^X-MimeOLE:"
;;         )))

(setq wl-summary-width nil)
(setq wl-subject-length-limit nil)
(setq wl-summary-subject-function 'identity)
(setq wl-summary-line-format "%n%T%P%1@%Y/%M/%D(%W)%h:%m %t%[%17(%c %f%) %] %100s")
(setq wl-summary-line-format-spec-alist
(append wl-summary-line-format-spec-alist
  '((?@ (wl-summary-line-attached)))))

(setq wl-prefetch-threshold 1000000)
(setq elmo-message-fetch-threshold 1000000)

;===================================
;; custom function
;===================================
;; display file size of a mail. (summary-mode)

;; (setq elmo-msgdb-extra-fields
;; 	        '("newsgroups"
;; 			  "list-id" "x-ml-name" "mailing-list"
;; 			  "x-mail-count" "x-ml-count" "x-sequence"
;; 			  "x-sent-to" "x-mailman-version"))
(setq elmo-msgdb-extra-fields
      '(
		"x-link"
;; 		"reply-to"
;;         "x-ml-name"
;;         "mailing-llist"
;;         "x-mailing-list"
;;         "sender"
;; 		"original-recipient"
;;         "newsgroups"
		)
)

(defun wl-summary-file-size () (interactive)
  (message "File Size (bytes): %d"
    (elmo-msgdb-overview-entity-get-size
      (elmo-message-entity wl-summary-buffer-elmo-folder (wl-summary-message-number))
    )
  )
)
(defun wl-summary-ldclip () (interactive)
  (setq field
;    (elmo-message-entity-field
   ( elmo-msgdb-overview-entity-get-extra-field 
      (elmo-message-entity wl-summary-buffer-elmo-folder (wl-summary-message-number))
      "x-link"
   )
  )
  (defvar LDC_PL "~/.emacs.d/ldc.pl"
	"*The command to clip to LDClip")
  (call-process
   LDC_PL nil 0 nil field )
  (message "%s" field)
)

(define-key wl-summary-mode-map "!" 'wl-summary-ldclip)
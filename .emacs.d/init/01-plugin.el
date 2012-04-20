;;; 03-hook.el ---
;; anything
(when (require 'anything-config nil t)
(setq
   anything-idle-delay 0.3
   anything-input-idle-delay 0.2
   anything-candidate-number-limit 100
   anything-quick-update t
   anything-enable-shortcuts 'alphabet)
(descbinds-anything-install)
)

(when (require 'anything-c-moccur nil t)
  (setq
   anything-c-moccur-anything-idle-delay 0.1
   anything-c-moccur-higligt-info-line-flag t
   anything-c-moccur-enable-auto-look-flag t
   anything-c-moccur-enable-initial-pattern t)
  )
   
(require 'wgrep nil t)

;; howm
(setq howm-directory "~/Dropbox/Document/howm")
(setq howm-menu-lang 'ja)
(when (require 'howm nil t)
  (define-key global-map (kbd "C-c h") 'howm-create)
  (define-key global-map (kbd "C-c ,,") 'howm-menu)
  )
(defun howm-save-buffer-and-kill ()
  (interactive)
  (when (and (buffer-file-name)
             (string-match "\\.howm" (buffer-file-name)))
    (save-buffer)
    (kill-buffer nil)))
(define-key howm-mode-map (kbd "C-c C-c") 'howm-save-buffer-and-kill)

;; gtags
;; (setq gtags-suggested-key-mapping t)
;; (require 'gtags nil t)
;; ctags
(require 'ctags nil t)
(when (and (require 'anything-exuberant-ctags nil t)
           (require 'anything-gtags nil t))
  (setq anything-for-tags
        (list anything-c-source-imenu
              anything-c-source-gtags-select
              anything-c-source-exuberant-ctags-select
              ))
  (defun anything-for-tags ()
    ""
    (interactive)
    (anything anything-for-tags
              (thing-at-point 'symbol)
              nil nil nil "*anything for tags*"))
  (define-key global-map (kbd "M-t") 'anything-for-tags)
  )


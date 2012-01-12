(auto-insert-mode)
(setq auto-insert-directory "~/.emacs.d/template/")
(define-auto-insert "\\.rb$" "skel.rb")

(which-func-mode 1)
(setq which-func-modes t)
(delete (assoc 'which-func-mode mode-line-format) mode-line-format)
(setq-default header-line-format '(which-func-mode ("" which-func-format)))

;===================================
;; Program
;===================================
(defun ruby-mode-hook ()
  (autoload 'ruby-mode "ruby-mode" nil t)
  (add-to-list 'auto-mode-alist '("Capfile" . ruby-mode))
  (add-to-list 'auto-mode-alist '("Gemfile" . ruby-mode))
  (add-to-list 'auto-mode-alist '("Rakefile" . ruby-mode))
  (add-to-list 'auto-mode-alist '("\\.rake\\'" . ruby-mode))
  (add-to-list 'auto-mode-alist '("\\.rb\\'" . ruby-mode))
  (add-to-list 'auto-mode-alist '("\\.ru\\'" . ruby-mode))
  (add-hook 'ruby-mode-hook '(lambda ()
                               (setq ruby-deep-arglist t)
                               (setq ruby-deep-indent-paren nil)
			       (setq c-tab-always-indent nil)
                               (require 'inf-ruby)
                               (require 'ruby-compilation))))
(defun rhtml-mode-hook ()
  (autoload 'rhtml-mode "rhtml-mode" nil t)
  (add-to-list 'auto-mode-alist '("\\.erb\\'" . rhtml-mode))
  (add-to-list 'auto-mode-alist '("\\.rjs\\'" . rhtml-mode))
  (add-hook 'rhtml-mode '(lambda ()
                           (define-key rhtml-mode-map (kbd "M-s") 'save-buffer))))

(defun yaml-mode-hook ()
  (autoload 'yaml-mode "yaml-mode" nil t)
  (add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))
  (add-to-list 'auto-mode-alist '("\\.yaml$" . yaml-mode)))

(defun css-mode-hook ()
  (autoload 'css-mode "css-mode" nil t)
  (add-hook 'css-mode-hook '(lambda ()
                              (setq css-indent-level 2)
                              (setq css-indent-offset 2))))

;auto-complete.el --- settings for auto-complete
;Code:
(eval-when-compile
  (require 'cl))

(require 'auto-complete-config)
(require 'auto-complete+)
(ac-config-default)
(setq ac-modes (append ac-modes '(lua-mode cmake-mode csharp-mode)))

										; After do this, isearch any string, M-: (match-data) always
										; return the list whose elements is integer
(global-auto-complete-mode 1)

(setq help-xref-following nil)
										; (bind-keys '(("RET" . ac-complete)
										;            ; ("RET" nil)
										;            ; ("M-j" nil)
										;          ) ac-complete-mode-map)

(add-to-list 'ac-dictionary-directories (expand-file-name "ac-dict" "~/.emacs.d/dict"))

(setq ac-auto-show-menu t
	  ac-auto-start t
	  ac-dwim t
	  ac-candidate-limit ac-menu-height
	  ac-quick-help-delay .5
	  ac-disable-faces nil)

(set-default 'ac-sources
			 '(ac-source-semantic-raw
			   ac-source-yasnippet
			   ac-source-dictionary
			   ac-source-abbrev
			   ac-source-words-in-buffer
			   ac-source-words-in-same-mode-buffers
			   ac-source-imenu
			   ac-source-files-in-current-dir
			   ac-source-filename))

;auto-complete.el ends here






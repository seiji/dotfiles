(auto-insert-mode)
(setq auto-insert-directory "~/.emacs.d/template/")
(define-auto-insert "\\.c$" "skel.c")
(define-auto-insert "\\.rb$" "skel.rb")
(define-auto-insert "\\.ru$" "skel.ru")
(define-auto-insert "\\.thor$" "skel.thor")
(define-auto-insert "\\.md$" "skel.md")
(define-auto-insert "\\.markdown$" "skel.md")

(which-func-mode 1)
(setq which-func-modes t)
(delete (assoc 'which-func-mode mode-line-format) mode-line-format)
(setq-default header-line-format '(which-func-mode ("" which-func-format)))

(setq auto-mode-alist (cons '("\\.txt" . markdown-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.md"  . gfm-mode)      auto-mode-alist))
(setq auto-mode-alist (cons '("\\.markdown"  . gfm-mode)      auto-mode-alist))

(setq auto-mode-alist (cons '("\\.mm"  . c++-mode)      auto-mode-alist))

(setq auto-mode-alist (cons '("\\.thor"     . ruby-mode)      auto-mode-alist))
(setq auto-mode-alist (cons '("config\\.ru" . ruby-mode)      auto-mode-alist))
(setq auto-mode-alist (cons '("Gemfile"     . ruby-mode)      auto-mode-alist))
(setq auto-mode-alist (cons '("Capfile"     . ruby-mode)      auto-mode-alist))

;======================================================================
;; Auto Complete
;======================================================================
;auto-complete.el --- settings for auto-complete
;Code:
(eval-when-compile (require 'cl))

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


;======================================================================
;; C Lang
;======================================================================
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
             (define-key c-mode-map "\C-c\C-c" 'quickrun)
             (define-key c-mode-map "\C-cb" 'c-begin-comment-box)
             (define-key c-mode-map "\C-ce" 'c-end-comment-box)))


;======================================================================
;; C Sharp
;======================================================================
(setq auto-mode-alist
      (append '(("\\.cs$" . csharp-mode)) auto-mode-alist))
(add-hook 'csharp-mode-hook
          '(lambda ()
             (setq compile-command
                   (concat "mcs " (buffer-file-name) " && mono " 
                           (replace-regexp-in-string "\.cs$" ".exe"
                                                     (buffer-file-name (current-buffer)))))
             (define-key csharp-mode-map "\C-c\C-c" 'compile)
             (setq indent-tabs-mode t)
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
;======================================================================
;; Python
;======================================================================
(add-hook 'python-mode-hook
          (function (lambda ()
                      (define-key python-mode-map "\C-c\C-c" 'quickrun)
                      (setq indent-tabs-mode nil))))

;======================================================================
;; Perl
;======================================================================
(defalias 'perl-mode 'cperl-mode)
(setq cperl-auto-newline t)
(setq cperl-indent-parens-as-block t)
(setq cperl-close-paren-offset -4)
(setq cperl-indent-level 4)
(setq cperl-label-offset -4)
(setq cperl-continued-statement-offset 4)

(add-hook 'cperl-mode-hook
          (lambda ()
            (set-face-bold-p 'cperl-array-face nil)
            (set-face-foreground 'cperl-array-face "DodgerBlue3")
            (set-face-background 'cperl-array-face "black")
            (set-face-foreground 'cperl-hash-face "DodgerBlue3")
            (set-face-bold-p 'cperl-hash-face nil)
            (set-face-italic-p 'cperl-hash-face nil)
            (set-face-background 'cperl-hash-face "black")
            (setq compile-command
                  (concat "perl " (buffer-file-name)))
            (cperl-define-key "\C-c\C-c" 'compile)
            )

)
;======================================================================
;; Ruby
;======================================================================
(defun search-gem-path (name)
    (shell-command-to-string
         (format "gem which %s | ruby -n -e 'if /lib/; print $_[0, $_.rindex(%%[lib])]; end'" name)))
(defun find-ruby-gem (name)
    (interactive "sRuby gem libraray name: ")
      (find-file (search-gem-path name)))

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
(add-hook 'ruby-mode-hook
          '(lambda ()
             (define-key ruby-mode-map "\C-m" 'newline-and-indent)
             (define-key ruby-mode-map "\C-c\C-c" 'quickrun)
;;             (define-key ruby-mode-map (kbd "C-@") 'anything-rdef)
             ))

;======================================================================
;; Other
;======================================================================

(defun coffee-mode-hook ()
  (autoload 'coffee-mode "coffee-mode" nil t)
  (add-to-list 'auto-mode-alist '("\\.coffee$" . coffee-mode))
  (add-to-list 'auto-mode-alist '("Cakefile" . coffee-mode))
)

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
(add-hook 'markdown-mode-hook
          '(lambda ()
             (define-key markdown-mode-map "\C-c\C-h1" 'markdown-insert-header-1)
             (define-key markdown-mode-map "\C-c\C-h2" 'markdown-insert-header-2)
             (define-key markdown-mode-map "\C-c\C-h3" 'markdown-insert-header-3)
             (define-key markdown-mode-map "\C-c\C-h4" 'markdown-insert-header-4)
             (define-key markdown-mode-map "\C-c\C-h5" 'markdown-insert-header-5)
             (define-key markdown-mode-map "\C-c\C-h6" 'markdown-insert-header-6)
             (define-key markdown-mode-map "\C-c\C-hs" 'markdown-insert-section)
             (define-key markdown-mode-map "\C-c\C-ht" 'markdown-insert-title)
			 ))








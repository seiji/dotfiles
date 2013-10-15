(auto-insert-mode)
(setq auto-insert-directory "~/.emacs.d/template/")
(define-auto-insert "\\.c$" "skel.c")
(define-auto-insert "\\.coffee$" "skel.coffee")
(define-auto-insert "\\.rb$" "skel.rb")
(define-auto-insert "\\.ru$" "skel.ru")
(define-auto-insert "\\.thor$" "skel.thor")
(define-auto-insert "\\.md$" "skel.md")
(define-auto-insert "\\.markdown$" "skel.md")
(define-auto-insert "Rakefile$" "skel.Rakefile")

(which-func-mode 1)
(setq which-func-modes t)
(delete (assoc 'which-func-mode mode-line-format) mode-line-format)
(setq-default header-line-format '(which-func-mode ("" which-func-format)))

(setq auto-mode-alist (cons '("\\.txt" . markdown-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.md"  . gfm-mode)      auto-mode-alist))
(setq auto-mode-alist (cons '("\\.markdown"  . gfm-mode)      auto-mode-alist))
(setq auto-mode-alist (cons '("\\.haml"  . haml-mode)      auto-mode-alist))

(setq auto-mode-alist (cons '("\\.mm"       . c++-mode)      auto-mode-alist))

(setq auto-mode-alist (cons '("\\.thor"     . ruby-mode)      auto-mode-alist))
(setq auto-mode-alist (cons '("\\.gemspec"     . ruby-mode)      auto-mode-alist))
(setq auto-mode-alist (cons '("config\\.ru" . ruby-mode)      auto-mode-alist))
(setq auto-mode-alist (cons '("Capfile"     . ruby-mode)      auto-mode-alist))
(setq auto-mode-alist (cons '("Gemfile"     . ruby-mode)      auto-mode-alist))
(setq auto-mode-alist (cons '("Guardfile"   . ruby-mode)      auto-mode-alist))
(setq auto-mode-alist (cons '("Rakefile"    . ruby-mode)      auto-mode-alist))

(setq auto-mode-alist (cons '("\\.pl"   . cperl-mode)      auto-mode-alist))
(setq auto-mode-alist (cons '("\\.pm"   . cperl-mode)      auto-mode-alist))
(setq auto-mode-alist (cons '("\\.psgi" . cperl-mode)      auto-mode-alist))
(setq auto-mode-alist (cons '("\\.t"    . cperl-mode)      auto-mode-alist))

(setq auto-mode-alist (cons '("Cakefile"    . coffee-mode)    auto-mode-alist))
(setq auto-mode-alist (cons '("\\.go"     . go-mode)      auto-mode-alist))

;======================================================================
;; Colorize Buffer of compilation
;======================================================================
(require 'ansi-color)
(defun colorize-compilation-buffer ()
  (toggle-read-only)
  (ansi-color-filter-region (point-min) (point-max))
  ;(ansi-color-apply-on-region (point-min) (point-max))
  (toggle-read-only))
(add-hook 'compilation-filter-hook 'colorize-compilation-buffer)

;======================================================================
;; Auto Complete
;======================================================================
;auto-complete.el --- settings for auto-complete
;Code:
(eval-when-compile (require 'cl))

(require 'auto-complete-config)
(require 'auto-complete+)
(require 'auto-complete-clang)

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
(global-set-key "\M-/" 'ac-start)
(define-key ac-complete-mode-map "\C-n" 'ac-next)
(define-key ac-complete-mode-map "\C-p" 'ac-previous)

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

(defvar anything-c-sources-local-gem-file
  '((name . "rubygems")
    (candidates-in-buffer)
    (init . (lambda ()
              (let ((gemfile-dir (block 'find-gemfile
                                   (let* ((cur-dir (file-name-directory
                                                    (expand-file-name (or (buffer-file-name)
                                                                          default-directory))))
                                          (cnt 0))
                                     (while (and (< (setq cnt (+ 1 cnt)) 10)
                                                 (not (equal cur-dir "/")))
                                       (when (member "Gemfile" (directory-files cur-dir))
                                         (return-from 'find-gemfile cur-dir))
                                       (setq cur-dir (expand-file-name (concat cur-dir "/.."))))
                                     ))))
                (anything-attrset 'gem-command
                                  (if gemfile-dir
                                      ;; (concat "bundle --gemfile " gemfile-path "/Gemfile exec gem")
                                      (concat "cd " gemfile-dir "; bundle exec gem")
                                    "gem"))
                (message (anything-attr 'gem-command)
                         (unless (anything-candidate-buffer)
                           (call-process-shell-command (concat (anything-attr 'gem-command) " list")
                                                       nil
                                                       (anything-candidate-buffer 'local)))))))
    (action . (lambda (gem-name)
                (let ((path (file-name-directory
                             (shell-command-to-string
                              (concat (anything-attr 'gem-command) " which "
                                      (replace-regexp-in-string "\s+(.+)$" "" gem-name))))))
                  (if (file-exists-p path)
                      (find-file path)
                    (message "no such file or directory:\"%s\"" path)))))))

(defun anything-local-gems ()
  (interactive)
  (anything-other-buffer
   '(anything-c-sources-local-gem-file)
   "*anything local gems*"
   ))

;======================================================================
;; yasnippet
;======================================================================
(add-to-list 'load-path
             "~/.emacs.d/plugins/yasnippet")
(require 'yasnippet)
(setq yas/snippet-dirs
      '(
       "~/.emacs.d/yasnippets/rspec-snippets"
       "~/.emacs.d/yasnippets"
       "~/.emacs.d/plugins/yasnippet/snippets"
       ))
(yas-global-mode 1)

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
             (define-key c-mode-map "\C-ce" 'c-end-comment-box)
             (c-set-style "linux")
             (setq c-auto-newline t)
             (setq c-hanging-braces-alist '((brace-list-open)
                                            (brace-entry-open)
                                            (substatement-open after)
                                            (block-close . c-snug-do-while)
                                            (extern-lang-open after)
                                            (inexpr-class-open after)
                                            (inexpr-class-close before)))
             (setq c-basic-offset 2)
             ))

(add-hook 'go-mode-hook
          (lambda ()
            (define-key go-mode-map "\C-c\C-c" 'quickrun)
            (local-set-key (kbd \"M-.\") 'godef-jump)
            ))

;======================================================================
;; Obj-C
;======================================================================
(add-to-list 'magic-mode-alist '("\\(.\\|\n\\)*\n@implementation" . objc-mode))
(add-to-list 'magic-mode-alist '("\\(.\\|\n\\)*\n@interface" . objc-mode))
(add-to-list 'magic-mode-alist '("\\(.\\|\n\\)*\n@protocol" . objc-mode))

(defvar xcode:sdkver "6.0")
(defvar xcode:sdkpath "/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer")
(defvar xcode:sdk (concat xcode:sdkpath "/SDKs/iPhoneSimulator" xcode:sdkver ".sdk"))

;; Jump between header and impl
(setq ff-other-file-alist
      '(("\\.mm?$" (".h"))
        ("\\.cc$"  (".hh" ".h"))
        ("\\.hh$"  (".cc" ".C"))
        ("\\.c$"   (".h"))
        ("\\.h$"   (".c" ".cc" ".C" ".CC" ".cxx" ".cpp" ".m" ".mm"))
        ("\\.C$"   (".H"  ".hh" ".h"))
        ("\\.H$"   (".C"  ".CC"))
        ("\\.CC$"  (".HH" ".H"  ".hh" ".h"))
        ("\\.HH$"  (".CC"))
        ("\\.cxx$" (".hh" ".h"))
        ("\\.cpp$" (".hpp" ".hh" ".h"))
        ("\\.hpp$" (".cpp" ".c"))))
(add-hook 'objc-mode-hook
          (lambda ()
            (define-key c-mode-base-map (kbd "C-c t") 'ff-find-other-file)
            ))

;; auto-complete-mode
(setq ac-modes (append ac-modes '(objc-mode)))
(setq ac-clang-flags (list "-D__IPHONE_OS_VERSION_MIN_REQUIRED=30200" "-x" "objective-c" "-std=gnu99" "-isysroot" xcode:sdk "-I." "-F.." "-fblocks"))
;; (setq ac-clang-prefix-header "stdafx.pch")
;; (setq ac-clang-flags '("-w" "-ferror-limit" "1"))
;(setq clang-completion-flags (list "-Wall" "-Wextra" "-fsyntax-only" "-ObjC" "-std=c99" "-isysroot" "/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator6.0.sdk" "-I." "-F.." "-D__IPHONE_OS_VERSION_MIN_REQUIRED=30200"))

(add-hook 'objc-mode-hook
          (function (lambda ()
;                      (push 'ac-source-clang-complete ac-sources)
                      (define-key objc-mode-map "\C-c\C-c" 'quickrun)
                      (setq indent-tabs-mode nil))))
;;

(defun xcode-compile ()
  (interactive)
  (if (directory-files "." nil ".*\.xcodeproj$" nil)
      (compile "rake xcode:cleanbuild")      ; use xcodebuild-rb with format
    (progn
      (cd "../")
      (xcode-compile))))

(add-hook 'objc-mode-hook
          (function (lambda ()
                      (define-key objc-mode-map "\C-c\C-c" 'quickrun)
                      (setq indent-tabs-mode nil))))

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
            (cperl-define-key "\C-c\C-c" 'quickrun) 
            )

)
; perl tidy
(defun perltidy-region ()
  "Run perltidy on the current region."
  (interactive)
  (save-excursion
    (shell-command-on-region (point) (mark) "perltidy -q -pbp" nil t)))
(defun perltidy-defun ()
  "Run perltidy on the current defun."
  (interactive)
  (save-excursion (mark-defun)
                  (perltidy-region)))

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
;; CoffeeScript
;======================================================================
(defun coffee-mode-hook ()
  (autoload 'coffee-mode "coffee-mode" nil t)
  (add-to-list 'auto-mode-alist '("\\.coffee$" . coffee-mode))
  (add-to-list 'auto-mode-alist '("Cakefile" . coffee-mode))
  )
(add-hook 'coffee-mode-hook '(lambda ()
                               (set (make-local-variable 'tab-width) 2))
                               (define-key coffee-mode-map "\C-c\C-c" 'quickrun)

                               ;; (setq compile-command
                               ;;       (concat "coffee " (buffer-file-name)))
                               ;; (define-key coffee-mode-map "\C-c\C-c" 'compile)))
                               ))


;======================================================================
;; other
;======================================================================

(defun rhtml-mode-hook ()
  (autoload 'rhtml-mode "rhtml-mode" nil t)
  (add-to-list 'auto-mode-alist '("\\.erb\\'" . rhtml-mode))
  (add-to-list 'auto-mode-alist '("\\.rjs\\'" . rhtml-mode))
  (add-hook 'rhtml-mode-hook '(lambda ()
                           (define-key rhtml-mode-map (kbd "M-s") 'save-buffer))))

(defun yaml-mode-hook ()
  (autoload 'yaml-mode "yaml-mode" nil t)
  (add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))
  (add-to-list 'auto-mode-alist '("\\.yaml$" . yaml-mode)))

(defun css-mode-hook ()
  (autoload 'css-mode "css-mode" nil t)
  (add-hook 'css-mode-hook '(lambda ()
                              (setq css-indent-level 2)
                              (setq css-indent-offset 2)
                              )))


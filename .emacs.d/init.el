;; emacs configuration
(push "/usr/local/bin" exec-path)

;===================================
;; el-o 24>
;===================================
(require 'package)
(setq package-archives (cons '("tromey" . "http://tromey.com/elpa/") package-archives))
(package-initialize)

(add-to-list 'load-path "~/.emacs.d/el-get/el-get")

(require 'el-get)

(setq el-get-sources
     '(
	   (:name auto-complete
			  :type git
			  :url "https://github.com/m2ym/auto-complete.git"
			  :load "auto-complete.el")
	   (:name auto-complete-plus
			  :type http
			  :url "https://raw.github.com/serenade/Serenade_System_Config/2bbb0cab7a9f2a392c1381abc9408dbb8482477a/emacs/home/Plugin/auto-complete+.el"
			  :load "auto-complete+.el")
       (:name init-loader
              :type http
              :url "http://coderepos.org/share/export/39089/lang/elisp/init-loader/init-loader.el"
              :load "init-loader.el")
       (:name sticky
              :type git
              :url "https://github.com/emacsmirror/sticky.git"
              :load "sticky.el")
       (:name recentf-ext
              :type emacswiki
              :features "recentf-ext")
       (:name gist :type elpa)
       (:name twittering-mode :type elpa)
       (:name fold-dwim
              :type git
              :url "https://github.com/emacsmirror/fold-dwim.git"
              :load "fold-dwim.el")
       (:name anything :type elpa)
       (:name quickrun
              :type git
              :url "https://github.com/syohex/emacs-quickrun.git"
              :load "quickrun.el")
       (:name httpcode
              :type git
              :url "https://github.com/rspivak/httpcode.el.git"
              :load "httpcode.el")
       (:name ruby-mode
              :type elpa
              :load "ruby-mode.el")
       (:name inf-ruby  :type elpa)
       (:name ruby-compilation :type elpa)
       (:name css-mode :type elpa)
       (:name textmate
              :type git
              :url "git://github.com/defunkt/textmate.el"
              :load "textmate.el")
       (:name rvm
             :type git
              :url "http://github.com/djwhitt/rvm.el.git"
              :load "rvm.el"
              :compile ("rvm.el")
              :after (lambda() (rvm-use-default)))
       (:name rhtml
              :type git
              :url "https://github.com/eschulte/rhtml.git"
              :features rhtml-mode)
       (:name yaml-mode
              :type git
              :url "http://github.com/yoshiki/yaml-mode.git"
              :features yaml-mode)
       )
)
(el-get 'sync)

(require 'init-loader)
(init-loader-load "~/.emacs.d/init")



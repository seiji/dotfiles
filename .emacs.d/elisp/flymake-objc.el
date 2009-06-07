(require 'flymake)

(defvar flymake-compiler "gcc")
(defvar flymake-compile-options nil)
(defvar flymake-compile-default-options (list "-Wall" "-Wextra" "-fsyntax-only"))

(defun flymake-objc-init ()
  (let* ((temp-file   (flymake-init-create-temp-buffer-copy
                       'flymake-create-temp-inplace))
         (local-file  (file-relative-name
                       temp-file
                       (file-name-directory buffer-file-name)))
         (options flymake-compile-default-options))
    (list flymake-compiler (append options (list local-file)))))

(push '("\\.m$" flymake-objc-init) flymake-allowed-file-name-masks)
(push '("\\.h$" flymake-objc-init) flymake-allowed-file-name-masks)

(add-hook 'objc-mode-hook
          '(lambda ()
                  (flymake-mode t)))

(provide 'flymake-objc)
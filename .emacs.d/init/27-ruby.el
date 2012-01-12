(add-hook 'ruby-mode-hook
          '(lambda ()
             (define-key ruby-mode-map "\C-c\C-c" 'quickrun)
))














dotfiles
========

Installation
------------

    $ hub clone seiji/dotfiles
    
### Install [brewdler](https://github.com/andrew/brewdler)   

    $ gem install brewdler

### Install package dependencies (includes [GNU Stow](http://www.gnu.org/software/stow/))

    $ cd dotfiles
    $ brewdle install
    
### Link a package

    $ stow -S -t $HOME -v zsh


Uninstallation
--------------

    $ stow -D -t $HOME -v zsh

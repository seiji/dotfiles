dotfiles
========

prerequires [bundler](http://bundler.io/).

Installation
------------

### Checkout src  

    $ hub clone seiji/dotfiles
    $ cd dotfiles
    
### Install gem dependencies   

    dotfiles $ bundle install

### Install package dependencies

Using [brewdler](https://github.com/andrew/brewdler):

    dotfiles $ brewdle install
    
### Link a package

Using [GNU Stow](http://www.gnu.org/software/stow/):

    dotfiles $ stow -S -t $HOME -v zsh

Uninstallation
--------------

    dotfiles $ stow -D -t $HOME -v zsh

dotfiles
========

prerequires Homebrew, [Bundler](http://bundler.io/).

Installation
------------

### Checkout src  

    $ hub clone seiji/dotfiles
    $ cd dotfiles
    
### Install gem dependencies   

Using [Bundler](http://bundler.io/):

    dotfiles $ bundle install

### Install package dependencies

    dotfiles $ brew bundle
    
### Link a package

Using [GNU Stow](http://www.gnu.org/software/stow/):

    dotfiles $ stow -S -t $HOME -v zsh

Uninstallation
--------------

    dotfiles $ stow -D -t $HOME -v zsh

### dircolors

see https://github.com/seebi/dircolors-solarized

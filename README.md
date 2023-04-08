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

## Arch Linux

### Natural scrolling with X11

Open the `/etc/X11/xorg.conf.d/40-libinput.conf` file, then add the **NaturalScrolling** option:

```
Section "InputClass"
        Identifier "libinput touchpad catchall"
        MatchIsTouchpad "on"
        MatchDevicePath "/dev/input/event*"
        Option "NaturalScrolling" "on"
        Driver "libinput"
EndSection
```

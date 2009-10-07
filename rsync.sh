#!/bin/sh

LIST=list.txt
SRC=~/
DEST=~/dotfiles/
RSYNC=/opt/local/bin/rsync

for x in `cat $LIST|grep -v "^#"`
do
    echo "--- $SRC$x => $DEST$x ---"
   $RSYNC -avz $SRC$x $DEST
done

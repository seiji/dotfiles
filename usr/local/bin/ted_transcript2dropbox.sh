ted_id=$1
DROPBOX_DIR=~/Dropbox/Document/TED

if [ ! -e $DROPBOX_DIR/$ted_id.txt ]; then
    curl http://www.ted.com/talks/subtitles/id/$1/lang/en | jsawk "return this.captions" | jsawk "return this.content" | jsawk -a 'return this.join("\n")' > $DROPBOX_DIR/$ted_id.txt
else
    echo "exit"
fi

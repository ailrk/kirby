#/usr/bin

BASEDIR=`dirname "$0"`
sbcl --script "$BASEDIR/choose-ibus.lisp"

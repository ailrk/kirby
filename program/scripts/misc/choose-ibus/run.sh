#/usr/bin/env bash

BASEDIR=`dirname "$0"`
sbcl --script "$BASEDIR/choose-ibus.lisp"

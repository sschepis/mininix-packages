#!/bin/sh
# clean.sh - clean everything.
set -e -u

# Read settings from .linuxdroidrc if existing
test -f $HOME/.linuxdroidrc && . $HOME/.linuxdroidrc
: ${LINUXDROID_TOPDIR:="$HOME/.linuxdroid-build"}

rm -Rf /data/* $LINUXDROID_TOPDIR

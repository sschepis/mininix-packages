#!/bin/sh
# clean.sh - clean everything.
set -e -u

# Read settings from .mininixrc if existing
test -f $HOME/.mininixrc && . $HOME/.mininixrc
: ${MININIX_TOPDIR:="$HOME/.mininix-build"}

rm -Rf /data/* $MININIX_TOPDIR

LINUXDROID_PKG_HOMEPAGE=http://profanity.im
LINUXDROID_PKG_DESCRIPTION="Profanity is a console based XMPP client written in C using ncurses and libstrophe, inspired by Irssi"
LINUXDROID_PKG_VERSION=0.5.1
LINUXDROID_PKG_REVISION=2
LINUXDROID_PKG_MAINTAINER="Oliver Schmidhauser @Neo-Oli"
LINUXDROID_PKG_SRCURL=http://profanity.im/profanity-${LINUXDROID_PKG_VERSION}.tar.gz
LINUXDROID_PKG_SHA256=e3513713e74ec3363fbdbac2919bdc17e249988780cc5a4589d1425807a7feb8
LINUXDROID_PKG_DEPENDS="libandroid-support,ncurses,glib,libmesode,libcurl,readline,libuuid,libotr,gpgme,python"
LINUXDROID_PKG_EXTRA_CONFIGURE_ARGS=" --disable-python-plugins"
LINUXDROID_PKG_BUILD_IN_SRC=yes

linuxdroid_step_pre_configure() {
  CPPFLAGS+=" -I$LINUXDROID_PREFIX/include/python3.7m"
  LDFLAGS+=" -lpython3.7m"
}

linuxdroid_step_post_configure() {
  # Enable python support manually, as trying to go using --enable-python-plugins
  # causes configure trying to execut python:
  echo '#define HAVE_PYTHON 1' >> $LINUXDROID_PKG_SRCDIR/src/config.h
  perl -p -i -e 's|#am__objects_2|am__objects_2|' $LINUXDROID_PKG_SRCDIR/Makefile
}

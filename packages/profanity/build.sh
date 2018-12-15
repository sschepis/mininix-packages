MININIX_PKG_HOMEPAGE=http://profanity.im
MININIX_PKG_DESCRIPTION="Profanity is a console based XMPP client written in C using ncurses and libstrophe, inspired by Irssi"
MININIX_PKG_VERSION=0.5.1
MININIX_PKG_REVISION=2
MININIX_PKG_MAINTAINER="Oliver Schmidhauser @Neo-Oli"
MININIX_PKG_SRCURL=http://profanity.im/profanity-${MININIX_PKG_VERSION}.tar.gz
MININIX_PKG_SHA256=e3513713e74ec3363fbdbac2919bdc17e249988780cc5a4589d1425807a7feb8
MININIX_PKG_DEPENDS="libandroid-support,ncurses,glib,libmesode,libcurl,readline,libuuid,libotr,gpgme,python"
MININIX_PKG_EXTRA_CONFIGURE_ARGS=" --disable-python-plugins"
MININIX_PKG_BUILD_IN_SRC=yes

mininix_step_pre_configure() {
  CPPFLAGS+=" -I$MININIX_PREFIX/include/python3.7m"
  LDFLAGS+=" -lpython3.7m"
}

mininix_step_post_configure() {
  # Enable python support manually, as trying to go using --enable-python-plugins
  # causes configure trying to execut python:
  echo '#define HAVE_PYTHON 1' >> $MININIX_PKG_SRCDIR/src/config.h
  perl -p -i -e 's|#am__objects_2|am__objects_2|' $MININIX_PKG_SRCDIR/Makefile
}

MININIX_PKG_HOMEPAGE=http://abook.sourceforge.net/
MININIX_PKG_DESCRIPTION="Abook is a text-based addressbook program designed to use with mutt mail client"
MININIX_PKG_VERSION=0.6.0pre2
MININIX_PKG_REVISION=1
MININIX_PKG_SRCURL=http://abook.sourceforge.net/devel/abook-$MININIX_PKG_VERSION.tar.gz
MININIX_PKG_SHA256=59d444504109dd96816e003b3023175981ae179af479349c34fa70bc12f6d385
MININIX_PKG_DEPENDS="libandroid-support, ncurses, readline"
MININIX_PKG_EXTRA_CONFIGURE_ARGS="--mandir=$MININIX_PREFIX/share/man"

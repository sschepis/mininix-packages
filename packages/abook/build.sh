LINUXDROID_PKG_HOMEPAGE=http://abook.sourceforge.net/
LINUXDROID_PKG_DESCRIPTION="Abook is a text-based addressbook program designed to use with mutt mail client"
LINUXDROID_PKG_VERSION=0.6.0pre2
LINUXDROID_PKG_REVISION=1
LINUXDROID_PKG_SRCURL=http://abook.sourceforge.net/devel/abook-$LINUXDROID_PKG_VERSION.tar.gz
LINUXDROID_PKG_SHA256=59d444504109dd96816e003b3023175981ae179af479349c34fa70bc12f6d385
LINUXDROID_PKG_DEPENDS="libandroid-support, ncurses, readline"
LINUXDROID_PKG_EXTRA_CONFIGURE_ARGS="--mandir=$LINUXDROID_PREFIX/share/man"

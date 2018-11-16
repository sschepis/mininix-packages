LINUXDROID_PKG_HOMEPAGE=http://a-nikolaev.github.io/curseofwar/
LINUXDROID_PKG_DESCRIPTION="Fast-paced action strategy game focusing on high-level strategic planning"
LINUXDROID_PKG_DEPENDS="ncurses"
LINUXDROID_PKG_VERSION=1.2.0
LINUXDROID_PKG_REVISION=2
LINUXDROID_PKG_SRCURL=https://github.com/a-nikolaev/curseofwar/archive/v${LINUXDROID_PKG_VERSION}.tar.gz
LINUXDROID_PKG_SHA256=91b7781e26341faa6b6999b6baf6e74ef532fa94303ab6a2bf9ff6d614a3f670

linuxdroid_step_make_install () {
	mkdir -p $LINUXDROID_PREFIX/share/man/man6
	cp curseofwar $LINUXDROID_PREFIX/bin
	cp $LINUXDROID_PKG_SRCDIR/curseofwar.6 $LINUXDROID_PREFIX/share/man/man6
}

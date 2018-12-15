MININIX_PKG_HOMEPAGE=http://a-nikolaev.github.io/curseofwar/
MININIX_PKG_DESCRIPTION="Fast-paced action strategy game focusing on high-level strategic planning"
MININIX_PKG_DEPENDS="ncurses"
MININIX_PKG_VERSION=1.2.0
MININIX_PKG_REVISION=2
MININIX_PKG_SRCURL=https://github.com/a-nikolaev/curseofwar/archive/v${MININIX_PKG_VERSION}.tar.gz
MININIX_PKG_SHA256=91b7781e26341faa6b6999b6baf6e74ef532fa94303ab6a2bf9ff6d614a3f670

mininix_step_make_install () {
	mkdir -p $MININIX_PREFIX/share/man/man6
	cp curseofwar $MININIX_PREFIX/bin
	cp $MININIX_PKG_SRCDIR/curseofwar.6 $MININIX_PREFIX/share/man/man6
}

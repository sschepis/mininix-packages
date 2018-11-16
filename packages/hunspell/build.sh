LINUXDROID_PKG_HOMEPAGE=https://hunspell.github.io
LINUXDROID_PKG_DESCRIPTION="Spell checker"
LINUXDROID_PKG_VERSION=1.6.2
LINUXDROID_PKG_REVISION=1
LINUXDROID_PKG_SRCURL=https://github.com/hunspell/hunspell/archive/v${LINUXDROID_PKG_VERSION}.tar.gz
LINUXDROID_PKG_SHA256=3cd9ceb062fe5814f668e4f22b2fa6e3ba0b339b921739541ce180cac4d6f4c4
LINUXDROID_PKG_EXTRA_CONFIGURE_ARGS="--with-ui --with-readline"
LINUXDROID_PKG_DEPENDS="ncurses, readline, hunspell-en-us"
LINUXDROID_PKG_BUILD_IN_SRC=yes

linuxdroid_step_pre_configure() {
	autoreconf -vfi
}

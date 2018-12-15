MININIX_PKG_HOMEPAGE=https://hunspell.github.io
MININIX_PKG_DESCRIPTION="Spell checker"
MININIX_PKG_VERSION=1.7.0
MININIX_PKG_SHA256=bb27b86eb910a8285407cf3ca33b62643a02798cf2eef468c0a74f6c3ee6bc8a
MININIX_PKG_SRCURL=https://github.com/hunspell/hunspell/archive/v${MININIX_PKG_VERSION}.tar.gz
MININIX_PKG_EXTRA_CONFIGURE_ARGS="--with-ui --with-readline"
MININIX_PKG_DEPENDS="ncurses, readline, hunspell-en-us"
MININIX_PKG_BUILD_IN_SRC=yes

mininix_step_pre_configure() {
	autoreconf -vfi
}

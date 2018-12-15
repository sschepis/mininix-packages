MININIX_PKG_HOMEPAGE=https://github.com/hboetes/mg
MININIX_PKG_DESCRIPTION="microscopic GNU Emacs-style editor"
MININIX_PKG_VERSION=20180927
MININIX_PKG_SHA256=fbb09729ea00fe42dcdbc96ac7fc1d2b89eac651dec49e4e7af52fad4f5788f6
MININIX_PKG_SRCURL=https://github.com/hboetes/mg/archive/$MININIX_PKG_VERSION.tar.gz
MININIX_PKG_DEPENDS="libbsd, ncurses"
MININIX_PKG_BUILD_IN_SRC=yes

mininix_step_pre_configure() {
	CFLAGS+=" $CPPFLAGS"
}

mininix_step_make_install() {
	make prefix=$PREFIX install
}

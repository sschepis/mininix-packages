LINUXDROID_PKG_HOMEPAGE=http://rigaux.org/hexedit.html
LINUXDROID_PKG_DESCRIPTION="view and edit files in hexadecimal or in ASCII"
LINUXDROID_PKG_VERSION=1.4.2
LINUXDROID_PKG_SHA256=c81ffb36af9243aefc0887e33dd8e41c4b22d091f1f27d413cbda443b0440d66
LINUXDROID_PKG_SRCURL=https://github.com/pixel/hexedit/archive/$LINUXDROID_PKG_VERSION.tar.gz
LINUXDROID_PKG_DEPENDS="ncurses"
LINUXDROID_PKG_BUILD_IN_SRC=yes

linuxdroid_step_pre_configure() {
	./autogen.sh
}

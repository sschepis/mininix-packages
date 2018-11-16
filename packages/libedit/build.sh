LINUXDROID_PKG_HOMEPAGE=https://thrysoee.dk/editline/
LINUXDROID_PKG_DESCRIPTION="Library providing line editing, history, and tokenization functions"
LINUXDROID_PKG_VERSION=20180525-3.1
LINUXDROID_PKG_SRCURL=https://thrysoee.dk/editline/libedit-${LINUXDROID_PKG_VERSION}.tar.gz
LINUXDROID_PKG_SHA256=c41bea8fd140fb57ba67a98ec1d8ae0b8ffa82f4aba9c35a87e5a9499e653116
LINUXDROID_PKG_DEPENDS="libandroid-support, ncurses"
LINUXDROID_PKG_RM_AFTER_INSTALL="share/man/man7/editline.7 share/man/man3/history.3"

linuxdroid_step_pre_configure() {
	CFLAGS+=" -D__STDC_ISO_10646__=201103L -DNBBY=CHAR_BIT"
}

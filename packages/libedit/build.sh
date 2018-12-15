MININIX_PKG_HOMEPAGE=https://thrysoee.dk/editline/
MININIX_PKG_DESCRIPTION="Library providing line editing, history, and tokenization functions"
MININIX_PKG_VERSION=20180525-3.1
MININIX_PKG_SRCURL=https://thrysoee.dk/editline/libedit-${MININIX_PKG_VERSION}.tar.gz
MININIX_PKG_SHA256=c41bea8fd140fb57ba67a98ec1d8ae0b8ffa82f4aba9c35a87e5a9499e653116
MININIX_PKG_DEPENDS="libandroid-support, ncurses"
MININIX_PKG_RM_AFTER_INSTALL="share/man/man7/editline.7 share/man/man3/history.3"

mininix_step_pre_configure() {
	CFLAGS+=" -D__STDC_ISO_10646__=201103L -DNBBY=CHAR_BIT"
}

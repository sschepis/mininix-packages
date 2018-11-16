LINUXDROID_PKG_HOMEPAGE=https://calcurse.org/
LINUXDROID_PKG_DESCRIPTION="calcurse is a calendar and scheduling application for the command line"
LINUXDROID_PKG_VERSION=4.3.0
LINUXDROID_PKG_SHA256=31ecc3dc09e1e561502b4c94f965ed6b167c03e9418438c4a7ad5bad2c785f9a
LINUXDROID_PKG_SRCURL=https://fossies.org/linux/privat/calcurse-$LINUXDROID_PKG_VERSION.tar.gz
LINUXDROID_PKG_DEPENDS="libandroid-support, ncurses"

linuxdroid_step_pre_configure() {
	export ac_cv_lib_pthread_pthread_create=yes
}

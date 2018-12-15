MININIX_PKG_HOMEPAGE=https://calcurse.org/
MININIX_PKG_DESCRIPTION="calcurse is a calendar and scheduling application for the command line"
MININIX_PKG_VERSION=4.3.0
MININIX_PKG_SHA256=31ecc3dc09e1e561502b4c94f965ed6b167c03e9418438c4a7ad5bad2c785f9a
MININIX_PKG_SRCURL=https://fossies.org/linux/privat/calcurse-$MININIX_PKG_VERSION.tar.gz
MININIX_PKG_DEPENDS="libandroid-support, ncurses"

mininix_step_pre_configure() {
	export ac_cv_lib_pthread_pthread_create=yes
}

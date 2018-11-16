LINUXDROID_PKG_HOMEPAGE=http://cscope.sourceforge.net/
LINUXDROID_PKG_DESCRIPTION="A developers tool for browsing program code"
LINUXDROID_PKG_VERSION=15.9
LINUXDROID_PKG_SHA256=c5505ae075a871a9cd8d9801859b0ff1c09782075df281c72c23e72115d9f159
LINUXDROID_PKG_SRCURL=https://fossies.org/linux/misc/cscope-${LINUXDROID_PKG_VERSION}.tar.gz
LINUXDROID_PKG_DEPENDS="ncurses"
LINUXDROID_PKG_EXTRA_CONFIGURE_ARGS="
hw_cv_func_snprintf_c99=yes
hw_cv_func_vsnprintf_c99=yes
--with-ncurses=$LINUXDROID_PREFIX
"

linuxdroid_step_pre_configure() {
	export LEXLIB=""
}

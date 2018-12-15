MININIX_PKG_HOMEPAGE=http://cscope.sourceforge.net/
MININIX_PKG_DESCRIPTION="A developers tool for browsing program code"
MININIX_PKG_VERSION=15.9
MININIX_PKG_SHA256=c5505ae075a871a9cd8d9801859b0ff1c09782075df281c72c23e72115d9f159
MININIX_PKG_SRCURL=https://fossies.org/linux/misc/cscope-${MININIX_PKG_VERSION}.tar.gz
MININIX_PKG_DEPENDS="ncurses"
MININIX_PKG_EXTRA_CONFIGURE_ARGS="
hw_cv_func_snprintf_c99=yes
hw_cv_func_vsnprintf_c99=yes
--with-ncurses=$MININIX_PREFIX
"

mininix_step_pre_configure() {
	export LEXLIB=""
}

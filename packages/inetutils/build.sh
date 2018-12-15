MININIX_PKG_HOMEPAGE=https://www.gnu.org/software/inetutils/
MININIX_PKG_DESCRIPTION="Collection of common network programs"
MININIX_PKG_VERSION=1.9.4
MININIX_PKG_REVISION=5
MININIX_PKG_SRCURL=https://mirrors.kernel.org/gnu/inetutils/inetutils-${MININIX_PKG_VERSION}.tar.xz
MININIX_PKG_SHA256=849d96f136effdef69548a940e3e0ec0624fc0c81265296987986a0dd36ded37
MININIX_PKG_DEPENDS="readline, libutil"
# These are old cruft / not suited for android
# (we --disable-traceroute as it requires root
# in favour of tracepath, which sets up traceroute
# as a symlink to tracepath):
MININIX_PKG_EXTRA_CONFIGURE_ARGS="
--disable-hostname
--disable-ifconfig
--disable-ping
--disable-ping6
--disable-rcp
--disable-rexec
--disable-rexecd
--disable-rlogin
--disable-rsh
--disable-traceroute
--disable-uucpd
"
MININIX_PKG_EXTRA_CONFIGURE_ARGS+=" ac_cv_lib_crypt_crypt=no"

mininix_step_pre_configure() {
	CPPFLAGS+=" -DLOGIN_PROCESS=6 -DDEAD_PROCESS=8 -DLOG_NFACILITIES=24"
	LDFLAGS+=" -llog" # for syslog
}

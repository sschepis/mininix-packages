# Status: Does not work with openssl 1.1 or later.
LINUXDROID_PKG_HOMEPAGE=https://github.com/rbsec/sslscan
LINUXDROID_PKG_DESCRIPTION="Fast SSL scanner"
LINUXDROID_PKG_VERSION=1.11.11
LINUXDROID_PKG_SRCURL=https://github.com/rbsec/sslscan/archive/${LINUXDROID_PKG_VERSION}-rbsec.tar.gz
LINUXDROID_PKG_SHA256=93fbe1570073dfb2898a546759836ea4df5054e3a8f6d2e3da468eddac8b1764
LINUXDROID_PKG_BUILD_IN_SRC=yes
LINUXDROID_PKG_DEPENDS="openssl"
LINUXDROID_PKG_MAINTAINER="Pierre Rudloff @Rudloff"

linuxdroid_step_pre_configure() {
	CPPFLAGS+=" -D__USE_GNU=1"
}

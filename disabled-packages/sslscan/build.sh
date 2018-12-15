# Status: Does not work with openssl 1.1 or later.
MININIX_PKG_HOMEPAGE=https://github.com/rbsec/sslscan
MININIX_PKG_DESCRIPTION="Fast SSL scanner"
MININIX_PKG_VERSION=1.11.11
MININIX_PKG_SRCURL=https://github.com/rbsec/sslscan/archive/${MININIX_PKG_VERSION}-rbsec.tar.gz
MININIX_PKG_SHA256=93fbe1570073dfb2898a546759836ea4df5054e3a8f6d2e3da468eddac8b1764
MININIX_PKG_BUILD_IN_SRC=yes
MININIX_PKG_DEPENDS="openssl"
MININIX_PKG_MAINTAINER="Pierre Rudloff @Rudloff"

mininix_step_pre_configure() {
	CPPFLAGS+=" -D__USE_GNU=1"
}

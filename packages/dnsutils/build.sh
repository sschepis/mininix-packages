MININIX_PKG_HOMEPAGE=https://www.isc.org/downloads/bind/
MININIX_PKG_DESCRIPTION="Clients provided with BIND"
MININIX_PKG_VERSION=9.13.4
MININIX_PKG_SHA256=ea02107ae0b22a5b3df76d4c45bd44414f1d17731fffc07813d8e5b4ce05f95b
MININIX_PKG_SRCURL="ftp://ftp.isc.org/isc/bind9/${MININIX_PKG_VERSION}/bind-${MININIX_PKG_VERSION}.tar.gz"
MININIX_PKG_DEPENDS="openssl, readline, resolv-conf"
MININIX_PKG_EXTRA_CONFIGURE_ARGS="
--disable-linux-caps
--without-python
--with-ecdsa=no
--with-gost=no
--with-gssapi=no
--with-libjson=no
--with-libtool
--with-libxml2=no
--with-openssl=$MININIX_PREFIX
--with-randomdev=/dev/random
--with-readline=-lreadline
--with-eddsa=no
"

mininix_step_pre_configure () {
	export BUILD_AR=ar
	export BUILD_CC=gcc
	export BUILD_CFLAGS=
	export BUILD_CPPFLAGS=
	export BUILD_LDFLAGS=
	export BUILD_RANLIB=

	_RESOLV_CONF=$MININIX_PREFIX/etc/resolv.conf
	CFLAGS+=" $CPPFLAGS -DRESOLV_CONF=\\\"$_RESOLV_CONF\\\""
	LDFLAGS+=" -llog"
}

mininix_step_make () {
	make -C lib/isc
	make -C lib/dns
	make -C lib/isccc
	make -C lib/isccfg
	make -C lib/bind9
	make -C lib/irs
	make -C bin/dig
	make -C bin/delv
	make -C bin/nsupdate
}

mininix_step_make_install () {
	make -C lib/isc install
	make -C lib/dns install
	make -C lib/isccc install
	make -C lib/isccfg install
	make -C lib/bind9 install
	make -C lib/irs install
	make -C bin/dig install
	make -C bin/delv install
	make -C bin/nsupdate install
}

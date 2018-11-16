LINUXDROID_PKG_HOMEPAGE=http://www.digip.org/jansson/
LINUXDROID_PKG_DESCRIPTION="C library for encoding, decoding and manipulating JSON data"
LINUXDROID_PKG_VERSION=2.11
LINUXDROID_PKG_SHA256=6ff0eab3a8baf64d21cae25f88a0311fb282006eb992080722a9099469c32881
LINUXDROID_PKG_SRCURL=https://github.com/akheron/jansson/archive/v${LINUXDROID_PKG_VERSION}.tar.gz
LINUXDROID_PKG_BUILD_IN_SRC=yes

linuxdroid_step_pre_configure () {
	autoreconf -fi
}

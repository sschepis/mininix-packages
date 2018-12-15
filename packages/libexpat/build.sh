MININIX_PKG_HOMEPAGE=https://libexpat.github.io/
MININIX_PKG_DESCRIPTION="XML parsing C library"
MININIX_PKG_VERSION=2.2.6
MININIX_PKG_SHA256=17b43c2716d521369f82fc2dc70f359860e90fa440bea65b3b85f0b246ea81f2
MININIX_PKG_SRCURL=https://github.com/libexpat/libexpat/releases/download/R_${MININIX_PKG_VERSION//./_}/expat-$MININIX_PKG_VERSION.tar.bz2
MININIX_PKG_EXTRA_CONFIGURE_ARGS="--without-xmlwf --without-docbook"

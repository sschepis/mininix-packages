LINUXDROID_PKG_HOMEPAGE=https://qalculate.github.io/
LINUXDROID_PKG_DESCRIPTION="Powerful and easy to use command line calculator"
LINUXDROID_PKG_VERSION=2.8.0
LINUXDROID_PKG_SHA256=b18f594894135e96121b1f81b341f05582ac73fc53680b6e35063623ceea6262
LINUXDROID_PKG_SRCURL=https://github.com/Qalculate/libqalculate/releases/download/v$LINUXDROID_PKG_VERSION/libqalculate-$LINUXDROID_PKG_VERSION.tar.gz
LINUXDROID_PKG_DEPENDS="libcurl, libmpfr, libxml2, readline, libgmp"
LINUXDROID_PKG_EXTRA_CONFIGURE_ARGS="--without-icu"

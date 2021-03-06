MININIX_PKG_HOMEPAGE=http://xmlsoft.org/libxslt/
MININIX_PKG_DESCRIPTION="XSLT processing library"
MININIX_PKG_VERSION=1.1.32
MININIX_PKG_SHA256=526ecd0abaf4a7789041622c3950c0e7f2c4c8835471515fd77eec684a355460
MININIX_PKG_SRCURL=ftp://xmlsoft.org/libxslt/libxslt-${MININIX_PKG_VERSION}.tar.gz
MININIX_PKG_EXTRA_CONFIGURE_ARGS="--without-python"
MININIX_PKG_DEPENDS="libxml2,libgcrypt"
MININIX_PKG_DEVPACKAGE_DEPENDS="libxml2-dev"
MININIX_PKG_INCLUDE_IN_DEVPACKAGE="bin/xslt-config lib/xsltConf.sh"

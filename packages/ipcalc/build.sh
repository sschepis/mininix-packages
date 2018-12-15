MININIX_PKG_HOMEPAGE=http://jodies.de/ipcalc
MININIX_PKG_DESCRIPTION="Calculates IP broadcast, network, Cisco wildcard mask, and host ranges"
MININIX_PKG_DEPENDS="perl"
MININIX_PKG_VERSION=0.41
MININIX_PKG_SRCURL=http://jodies.de/ipcalc-archive/ipcalc-${MININIX_PKG_VERSION}.tar.gz
MININIX_PKG_SHA256=dda9c571ce3369e5b6b06e92790434b54bec1f2b03f1c9df054c0988aa4e2e8a

mininix_step_make_install () {
  cp $MININIX_PKG_SRCDIR/ipcalc $MININIX_PREFIX/bin/
}


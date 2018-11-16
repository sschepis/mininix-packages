LINUXDROID_PKG_HOMEPAGE=http://jodies.de/ipcalc
LINUXDROID_PKG_DESCRIPTION="Calculates IP broadcast, network, Cisco wildcard mask, and host ranges"
LINUXDROID_PKG_DEPENDS="perl"
LINUXDROID_PKG_VERSION=0.41
LINUXDROID_PKG_SRCURL=http://jodies.de/ipcalc-archive/ipcalc-${LINUXDROID_PKG_VERSION}.tar.gz
LINUXDROID_PKG_SHA256=dda9c571ce3369e5b6b06e92790434b54bec1f2b03f1c9df054c0988aa4e2e8a

linuxdroid_step_make_install () {
  cp $LINUXDROID_PKG_SRCDIR/ipcalc $LINUXDROID_PREFIX/bin/
}


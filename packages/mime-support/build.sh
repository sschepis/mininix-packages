MININIX_PKG_HOMEPAGE=https://packages.debian.org/en/stretch/mime-support
MININIX_PKG_DESCRIPTION="MIME type associations for file types"
MININIX_PKG_VERSION=3.61
MININIX_PKG_SHA256=027fa5b709b3dabfb8dcdf68ab8c59e1f534a37eb1d1b5160ee1fd788103131d
MININIX_PKG_SRCURL=http://http.debian.net/debian/pool/main/m/mime-support/mime-support_$MININIX_PKG_VERSION.tar.gz
MININIX_PKG_PLATFORM_INDEPENDENT=yes
MININIX_PKG_CONFFILES="etc/mime.types"
# etc/mime.types was previously in mutt:
MININIX_PKG_CONFLICTS="mutt (<< 1.8.3-1)"

mininix_step_make_install() {
	cp $MININIX_PKG_SRCDIR/mime.types $MININIX_PREFIX/etc
}

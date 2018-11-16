LINUXDROID_PKG_HOMEPAGE=https://packages.debian.org/en/stretch/mime-support
LINUXDROID_PKG_DESCRIPTION="MIME type associations for file types"
LINUXDROID_PKG_VERSION=3.61
LINUXDROID_PKG_SHA256=027fa5b709b3dabfb8dcdf68ab8c59e1f534a37eb1d1b5160ee1fd788103131d
LINUXDROID_PKG_SRCURL=http://http.debian.net/debian/pool/main/m/mime-support/mime-support_$LINUXDROID_PKG_VERSION.tar.gz
LINUXDROID_PKG_PLATFORM_INDEPENDENT=yes
LINUXDROID_PKG_CONFFILES="etc/mime.types"
# etc/mime.types was previously in mutt:
LINUXDROID_PKG_CONFLICTS="mutt (<< 1.8.3-1)"

linuxdroid_step_make_install() {
	cp $LINUXDROID_PKG_SRCDIR/mime.types $LINUXDROID_PREFIX/etc
}

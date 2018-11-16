LINUXDROID_PKG_HOMEPAGE=https://icecast.org
LINUXDROID_PKG_DESCRIPTION="Icecast is a streaming media (audio/video) server"
LINUXDROID_PKG_VERSION=2.4.4
LINUXDROID_PKG_SRCURL=https://downloads.xiph.org/releases/icecast/icecast-$LINUXDROID_PKG_VERSION.tar.gz
LINUXDROID_PKG_SHA256=49b5979f9f614140b6a38046154203ee28218d8fc549888596a683ad604e4d44
LINUXDROID_PKG_DEPENDS="libcurl, libgnutls, libogg, libvorbis, libxml2, libxslt, mime-support, openssl"
LINUXDROID_PKG_BUILD_IN_SRC=yes

linuxdroid_step_pre_configure() {
    perl -p -i -e "s#/etc/mime.types#$LINUXDROID_PREFIX/etc/mime.types#" $LINUXDROID_PKG_SRCDIR/src/cfgfile.c
}

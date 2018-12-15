MININIX_PKG_HOMEPAGE=https://icecast.org
MININIX_PKG_DESCRIPTION="Icecast is a streaming media (audio/video) server"
MININIX_PKG_VERSION=2.4.4
MININIX_PKG_SRCURL=https://downloads.xiph.org/releases/icecast/icecast-$MININIX_PKG_VERSION.tar.gz
MININIX_PKG_SHA256=49b5979f9f614140b6a38046154203ee28218d8fc549888596a683ad604e4d44
MININIX_PKG_DEPENDS="libcurl, libgnutls, libogg, libvorbis, libxml2, libxslt, mime-support, openssl"
MININIX_PKG_BUILD_IN_SRC=yes

mininix_step_pre_configure() {
    perl -p -i -e "s#/etc/mime.types#$MININIX_PREFIX/etc/mime.types#" $MININIX_PKG_SRCDIR/src/cfgfile.c
}

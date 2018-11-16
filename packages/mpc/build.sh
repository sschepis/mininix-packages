LINUXDROID_PKG_HOMEPAGE=https://www.musicpd.org/clients/mpc/
LINUXDROID_PKG_DESCRIPTION="Minimalist command line interface for MPD"
LINUXDROID_PKG_MAINTAINER="Matthew Klein @mklein994"
LINUXDROID_PKG_DEPENDS="libmpdclient"
LINUXDROID_PKG_VERSION=0.31
LINUXDROID_PKG_SHA256=62373e83a8a165b2ed43967975efecd3feee530f4557d6b861dd08aa89d52b2d
LINUXDROID_PKG_SRCURL=https://www.musicpd.org/download/mpc/${LINUXDROID_PKG_VERSION:0:1}/mpc-$LINUXDROID_PKG_VERSION.tar.xz
# Include some useful scripts for editing playlists
LINUXDROID_PKG_KEEP_SHARE_DOC=yes
# There seems to be issues with sphinx-build when using concurrent builds:
LINUXDROID_MAKE_PROCESSES=1

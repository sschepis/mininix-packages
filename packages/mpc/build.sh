MININIX_PKG_HOMEPAGE=https://www.musicpd.org/clients/mpc/
MININIX_PKG_DESCRIPTION="Minimalist command line interface for MPD"
MININIX_PKG_MAINTAINER="Matthew Klein @mklein994"
MININIX_PKG_DEPENDS="libmpdclient"
MININIX_PKG_VERSION=0.31
MININIX_PKG_SHA256=62373e83a8a165b2ed43967975efecd3feee530f4557d6b861dd08aa89d52b2d
MININIX_PKG_SRCURL=https://www.musicpd.org/download/mpc/${MININIX_PKG_VERSION:0:1}/mpc-$MININIX_PKG_VERSION.tar.xz
# Include some useful scripts for editing playlists
MININIX_PKG_KEEP_SHARE_DOC=yes
# There seems to be issues with sphinx-build when using concurrent builds:
MININIX_MAKE_PROCESSES=1

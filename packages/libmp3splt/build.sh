LINUXDROID_PKG_HOMEPAGE=http://mp3splt.sourceforge.net
LINUXDROID_PKG_DESCRIPTION="Utility to split MP3, Ogg Vorbis and native FLAC files without decoding"
LINUXDROID_PKG_VERSION=0.9.2
LINUXDROID_PKG_REVISION=3
LINUXDROID_PKG_SRCURL=http://prdownloads.sourceforge.net/mp3splt/libmp3splt-${LINUXDROID_PKG_VERSION}.tar.gz
LINUXDROID_PKG_SHA256=30eed64fce58cb379b7cc6a0d8e545579cb99d0f0f31eb00b9acc8aaa1b035dc
LINUXDROID_PKG_DEPENDS="libmad, libid3tag, libvorbis, libflac, pcre, libtool"
LINUXDROID_PKG_EXTRA_CONFIGURE_ARGS="--disable-cutter"

MININIX_PKG_HOMEPAGE=http://www.vorbis.com
MININIX_PKG_DESCRIPTION="Ogg Vorbis tools"
MININIX_PKG_VERSION=1.4.0
MININIX_PKG_REVISION=3
MININIX_PKG_SRCURL=http://downloads.xiph.org/releases/vorbis/vorbis-tools-${MININIX_PKG_VERSION}.tar.gz
MININIX_PKG_SHA256=a389395baa43f8e5a796c99daf62397e435a7e73531c9f44d9084055a05d22bc
# libflac for flac support in oggenc:
MININIX_PKG_DEPENDS="libvorbis, libflac, libogg"

mininix_step_pre_configure() {
	LDFLAGS+=" -lm"
}

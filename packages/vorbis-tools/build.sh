LINUXDROID_PKG_HOMEPAGE=http://www.vorbis.com
LINUXDROID_PKG_DESCRIPTION="Ogg Vorbis tools"
LINUXDROID_PKG_VERSION=1.4.0
LINUXDROID_PKG_REVISION=3
LINUXDROID_PKG_SRCURL=http://downloads.xiph.org/releases/vorbis/vorbis-tools-${LINUXDROID_PKG_VERSION}.tar.gz
LINUXDROID_PKG_SHA256=a389395baa43f8e5a796c99daf62397e435a7e73531c9f44d9084055a05d22bc
# libflac for flac support in oggenc:
LINUXDROID_PKG_DEPENDS="libvorbis, libflac, libogg"

linuxdroid_step_pre_configure() {
	LDFLAGS+=" -lm"
}

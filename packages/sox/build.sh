LINUXDROID_PKG_HOMEPAGE=http://sox.sourceforge.net/
LINUXDROID_PKG_DESCRIPTION="Command line utility for converting between and applying effects to various audio files formats"
LINUXDROID_PKG_VERSION=14.4.2
LINUXDROID_PKG_REVISION=10
LINUXDROID_PKG_SRCURL=http://downloads.sourceforge.net/project/sox/sox/${LINUXDROID_PKG_VERSION}/sox-${LINUXDROID_PKG_VERSION}.tar.bz2
LINUXDROID_PKG_SHA256=81a6956d4330e75b5827316e44ae381e6f1e8928003c6aa45896da9041ea149c
LINUXDROID_PKG_EXTRA_CONFIGURE_ARGS="
--with-oggvorbis
--without-opus
--with-pulseaudio=dyn
--without-sndfile
"
# Depend on file for libmagic.so linking:
LINUXDROID_PKG_DEPENDS="libltdl, file, libpng, libmp3lame, libogg, libvorbis, libandroid-glob, libflac, libid3tag, libmad, libpulseaudio"

linuxdroid_step_pre_configure() {
	LDFLAGS+=" -landroid-glob"
	CPPFLAGS+=" -D_FSTDIO"
}

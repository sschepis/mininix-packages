MININIX_PKG_HOMEPAGE=http://sox.sourceforge.net/
MININIX_PKG_DESCRIPTION="Command line utility for converting between and applying effects to various audio files formats"
MININIX_PKG_VERSION=14.4.2
MININIX_PKG_REVISION=10
MININIX_PKG_SRCURL=http://downloads.sourceforge.net/project/sox/sox/${MININIX_PKG_VERSION}/sox-${MININIX_PKG_VERSION}.tar.bz2
MININIX_PKG_SHA256=81a6956d4330e75b5827316e44ae381e6f1e8928003c6aa45896da9041ea149c
MININIX_PKG_EXTRA_CONFIGURE_ARGS="
--with-oggvorbis
--without-opus
--with-pulseaudio=dyn
--without-sndfile
"
# Depend on file for libmagic.so linking:
MININIX_PKG_DEPENDS="libltdl, file, libpng, libmp3lame, libogg, libvorbis, libandroid-glob, libflac, libid3tag, libmad, libpulseaudio"

mininix_step_pre_configure() {
	LDFLAGS+=" -landroid-glob"
	CPPFLAGS+=" -D_FSTDIO"
}

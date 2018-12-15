MININIX_PKG_HOMEPAGE=http://www.alsa-project.org
MININIX_PKG_VERSION=1.1.1
MININIX_PKG_SRCURL=ftp://ftp.alsa-project.org/pub/plugins/alsa-plugins-$MININIX_PKG_VERSION.tar.bz2
MININIX_PKG_SHA256=8ea4d1e082c36528a896a2581e5eb62d4dc2683238e353050d0d624e65f901f1
MININIX_PKG_DEPENDS="alsa-lib, pulseaudio"
MININIX_PKG_EXTRA_MAKE_ARGS='SUBDIRS=pulse'

mininix_step_post_make_install () {
    cp $MININIX_PKG_BUILDER_DIR/asound.conf $MININIX_PREFIX/etc
}

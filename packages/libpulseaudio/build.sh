LINUXDROID_PKG_HOMEPAGE=https://www.freedesktop.org/wiki/Software/PulseAudio
LINUXDROID_PKG_DESCRIPTION="A featureful, general-purpose sound server - shared libraries"
LINUXDROID_PKG_VERSION=12.2
LINUXDROID_PKG_REVISION=8
LINUXDROID_PKG_SHA256=809668ffc296043779c984f53461c2b3987a45b7a25eb2f0a1d11d9f23ba4055
LINUXDROID_PKG_SRCURL=https://www.freedesktop.org/software/pulseaudio/releases/pulseaudio-${LINUXDROID_PKG_VERSION}.tar.xz
LINUXDROID_PKG_DEPENDS="libltdl, libsndfile, libandroid-glob, libsoxr"
LINUXDROID_PKG_BUILD_DEPENDS="libtool"
LINUXDROID_PKG_INCLUDE_IN_DEVPACKAGE="share/vala"
LINUXDROID_PKG_EXTRA_CONFIGURE_ARGS="--disable-neon-opt
--disable-alsa
--disable-esound
--disable-glib2
--disable-openssl
--without-caps
--with-database=simple
--disable-memfd
--disable-gsettings
--bindir=$LINUXDROID_PREFIX/libexec
ax_cv_PTHREAD_PRIO_INHERIT=no
ac_cv_func_posix_madvise=no"
LINUXDROID_PKG_CONFFILES="etc/pulse/client.conf etc/pulse/daemon.conf etc/pulse/default.pa etc/pulse/system.pa"

linuxdroid_step_pre_configure () {
	# Our aaudio sink module needs libaaudio.so from a later android api version:
	local _NDK_ARCHNAME=$LINUXDROID_ARCH
	if [ "$LINUXDROID_ARCH" = "aarch64" ]; then
		_NDK_ARCHNAME=arm64
	elif [ "$LINUXDROID_ARCH" = "i686" ]; then
		_NDK_ARCHNAME=x86
	fi
	mkdir $LINUXDROID_PKG_TMPDIR/libaaudio
	cp $NDK/platforms/android-26/arch-$_NDK_ARCHNAME/usr/lib*/libaaudio.so \
		$LINUXDROID_PKG_TMPDIR/libaaudio/
	LDFLAGS+=" -L$LINUXDROID_PKG_TMPDIR/libaaudio/"

	mkdir $LINUXDROID_PKG_SRCDIR/src/modules/sles
	cp $LINUXDROID_PKG_BUILDER_DIR/module-sles-sink.c $LINUXDROID_PKG_SRCDIR/src/modules/sles
	mkdir $LINUXDROID_PKG_SRCDIR/src/modules/aaudio
	cp $LINUXDROID_PKG_BUILDER_DIR/module-aaudio-sink.c $LINUXDROID_PKG_SRCDIR/src/modules/aaudio

	intltoolize --automake --copy --force

	LDFLAGS+=" -llog -landroid-glob"
}

linuxdroid_step_post_make_install () {
	# Some binaries link against these:
	cd $LINUXDROID_PREFIX/lib
	for lib in pulseaudio/lib*.so* pulse-${LINUXDROID_PKG_VERSION}/modules/lib*.so*; do
		ln -s -f $lib `basename $lib`
	done

	# Pulseaudio fails to start when it cannot detect any sound hardware
	# so disable hardware detection.
	sed -i $LINUXDROID_PREFIX/etc/pulse/default.pa \
		-e '/^load-module module-detect$/s/^/#/'
	echo "load-module module-sles-sink" >> $LINUXDROID_PREFIX/etc/pulse/default.pa
	echo "#load-module module-aaudio-sink" >> $LINUXDROID_PREFIX/etc/pulse/default.pa

	if [ "$LINUXDROID_ARCH_BITS" = 32 ]; then
		SYSTEM_LIB=lib
	else
		SYSTEM_LIB=lib64
	fi

	cd $LINUXDROID_PREFIX/libexec
	for bin in pacat pacmd pactl pasuspender pulseaudio; do
		rm -f ../bin/$bin
		echo "#!$LINUXDROID_PREFIX/bin/sh" >> ../bin/$bin
		echo "LD_LIBRARY_PATH=/system/$SYSTEM_LIB:/system/vendor/$SYSTEM_LIB:$LINUXDROID_PREFIX/lib exec $LINUXDROID_PREFIX/libexec/$bin \"\$@\"" >> ../bin/$bin
		chmod +x ../bin/$bin
	done
}

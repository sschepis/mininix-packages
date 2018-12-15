MININIX_PKG_HOMEPAGE=https://www.freedesktop.org/wiki/Software/PulseAudio
MININIX_PKG_DESCRIPTION="A featureful, general-purpose sound server - shared libraries"
MININIX_PKG_VERSION=12.2
MININIX_PKG_REVISION=8
MININIX_PKG_SHA256=809668ffc296043779c984f53461c2b3987a45b7a25eb2f0a1d11d9f23ba4055
MININIX_PKG_SRCURL=https://www.freedesktop.org/software/pulseaudio/releases/pulseaudio-${MININIX_PKG_VERSION}.tar.xz
MININIX_PKG_DEPENDS="libltdl, libsndfile, libandroid-glob, libsoxr"
MININIX_PKG_BUILD_DEPENDS="libtool"
MININIX_PKG_INCLUDE_IN_DEVPACKAGE="share/vala"
MININIX_PKG_EXTRA_CONFIGURE_ARGS="--disable-neon-opt
--disable-alsa
--disable-esound
--disable-glib2
--disable-openssl
--without-caps
--with-database=simple
--disable-memfd
--disable-gsettings
--bindir=$MININIX_PREFIX/libexec
ax_cv_PTHREAD_PRIO_INHERIT=no
ac_cv_func_posix_madvise=no"
MININIX_PKG_CONFFILES="etc/pulse/client.conf etc/pulse/daemon.conf etc/pulse/default.pa etc/pulse/system.pa"

mininix_step_pre_configure () {
	# Avoid aclocal-1.15 dependency:
	NOCONFIGURE=1 ./bootstrap.sh

	# Our aaudio sink module needs libaaudio.so from a later android api version:
	local _NDK_ARCHNAME=$MININIX_ARCH
	if [ "$MININIX_ARCH" = "aarch64" ]; then
		_NDK_ARCHNAME=arm64
	elif [ "$MININIX_ARCH" = "i686" ]; then
		_NDK_ARCHNAME=x86
	fi
	mkdir $MININIX_PKG_TMPDIR/libaaudio
	cp $NDK/platforms/android-26/arch-$_NDK_ARCHNAME/usr/lib*/libaaudio.so \
		$MININIX_PKG_TMPDIR/libaaudio/
	LDFLAGS+=" -L$MININIX_PKG_TMPDIR/libaaudio/"

	mkdir $MININIX_PKG_SRCDIR/src/modules/sles
	cp $MININIX_PKG_BUILDER_DIR/module-sles-sink.c $MININIX_PKG_SRCDIR/src/modules/sles
	mkdir $MININIX_PKG_SRCDIR/src/modules/aaudio
	cp $MININIX_PKG_BUILDER_DIR/module-aaudio-sink.c $MININIX_PKG_SRCDIR/src/modules/aaudio

	intltoolize --automake --copy --force

	LDFLAGS+=" -llog -landroid-glob"
}

mininix_step_post_make_install () {
	# Some binaries link against these:
	cd $MININIX_PREFIX/lib
	for lib in pulseaudio/lib*.so* pulse-${MININIX_PKG_VERSION}/modules/lib*.so*; do
		ln -s -f $lib `basename $lib`
	done

	# Pulseaudio fails to start when it cannot detect any sound hardware
	# so disable hardware detection.
	sed -i $MININIX_PREFIX/etc/pulse/default.pa \
		-e '/^load-module module-detect$/s/^/#/'
	echo "load-module module-sles-sink" >> $MININIX_PREFIX/etc/pulse/default.pa
	echo "#load-module module-aaudio-sink" >> $MININIX_PREFIX/etc/pulse/default.pa

	if [ "$MININIX_ARCH_BITS" = 32 ]; then
		SYSTEM_LIB=lib
	else
		SYSTEM_LIB=lib64
	fi

	cd $MININIX_PREFIX/libexec
	for bin in pacat pacmd pactl pasuspender pulseaudio; do
		rm -f ../bin/$bin
		echo "#!$MININIX_PREFIX/bin/sh" >> ../bin/$bin
		echo "LD_LIBRARY_PATH=/system/$SYSTEM_LIB:/system/vendor/$SYSTEM_LIB:$MININIX_PREFIX/lib exec $MININIX_PREFIX/libexec/$bin \"\$@\"" >> ../bin/$bin
		chmod +x ../bin/$bin
	done
}

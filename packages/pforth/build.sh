LINUXDROID_PKG_HOMEPAGE=http://www.softsynth.com/pforth/
LINUXDROID_PKG_DESCRIPTION="Portable Forth in C"
_COMMIT=ee8dc9e9e0f59b8e38dec3732caefe9f3af2b431
LINUXDROID_PKG_VERSION=20180513
LINUXDROID_PKG_SHA256=3cf472bb944aa53b0eb0b93d021c8c2c0eff18dd2e3e54daddaf4af342e441ea
LINUXDROID_PKG_SRCURL=https://github.com/philburk/pforth/archive/${_COMMIT}.zip
LINUXDROID_PKG_HOSTBUILD=yes

linuxdroid_step_post_configure () {
	# Avoid caching the host build as it differs between arches
	# and is quite fast here anyway:
	rm -Rf $LINUXDROID_PKG_HOSTBUILD_DIR
}

linuxdroid_step_host_build () {
	local M32=""
	if [ $LINUXDROID_ARCH_BITS = "32" ]; then
		M32="-m32"
	fi
	cp -Rf $LINUXDROID_PKG_SRCDIR/* .
	cd build/unix
	CC="gcc $M32" make pfdicdat.h
	CC="gcc $M32" make all
}

linuxdroid_step_pre_configure () {
	for file in pfdicdat.h pforth; do
		cp $LINUXDROID_PKG_HOSTBUILD_DIR/build/unix/$file $LINUXDROID_PKG_SRCDIR/build/unix/$file
		touch -d "next hour" $LINUXDROID_PKG_SRCDIR/build/unix/$file
	done

	export LINUXDROID_PKG_BUILDDIR=$LINUXDROID_PKG_SRCDIR/build/unix
	export CC="$CC $CFLAGS"
}
linuxdroid_step_make_install () {
	cp $LINUXDROID_PKG_BUILDDIR/pforth_standalone $LINUXDROID_PREFIX/bin/pforth
}

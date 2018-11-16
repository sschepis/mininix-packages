LINUXDROID_PKG_HOMEPAGE=https://picolisp.com
LINUXDROID_PKG_DESCRIPTION="Lisp interpreter and application server framework"
LINUXDROID_PKG_DEPENDS="libcrypt, openssl"
LINUXDROID_PKG_VERSION=18.9.18
LINUXDROID_PKG_SHA256=aa14a35b7d071c068545d835db74c77538b115b37316dd1b331bd0dee2af0f24
# We use our bintray mirror since old version snapshots are not kept on main site.
LINUXDROID_PKG_SRCURL=https://dl.bintray.com/linuxdroid/upstream/picolisp_${LINUXDROID_PKG_VERSION}.tar.gz
LINUXDROID_PKG_BUILD_IN_SRC=true
# arm and i686: The c code uses gcc-specific "variable length array in structure":
# x86_64: The assembly is not position-independent:
LINUXDROID_PKG_BLACKLISTED_ARCHES="arm, i686, x86_64"

linuxdroid_step_pre_configure() {
	# Validate that we have the right version:
	grep -q "Version ${LINUXDROID_PKG_VERSION//./ }" src64/version.l || {
		linuxdroid_error_exit "Picolisp version needs to be bumped"
	}

	if [ $LINUXDROID_ARCH_BITS = 64 ]; then
		cd $LINUXDROID_PKG_SRCDIR
		if [ $LINUXDROID_ARCH = "aarch64" ]; then
			export LINUXDROID_PKG_EXTRA_MAKE_ARGS=arm64.android
		else
			linuxdroid_error_exit "Unsupported arch: $LINUXDROID_ARCH"
		fi
		LINUXDROID_PKG_SRCDIR=$LINUXDROID_PKG_SRCDIR/src64
	else
		LINUXDROID_PKG_SRCDIR=$LINUXDROID_PKG_SRCDIR/src
	fi
	LINUXDROID_PKG_BUILDDIR=$LINUXDROID_PKG_SRCDIR
	ORIG_CFLAGS="$CFLAGS"
	CFLAGS+=" -c $LDFLAGS $CPPFLAGS"
}

linuxdroid_step_make_install () {
	cd $LINUXDROID_PKG_SRCDIR/

	if [ $LINUXDROID_ARCH_BITS = "64" ]; then
		$LINUXDROID_HOST_PLATFORM-as -o ${LINUXDROID_PKG_EXTRA_MAKE_ARGS}.base.o ${LINUXDROID_PKG_EXTRA_MAKE_ARGS}.base.s
		$LINUXDROID_HOST_PLATFORM-as -o ${LINUXDROID_PKG_EXTRA_MAKE_ARGS}.ext.o ${LINUXDROID_PKG_EXTRA_MAKE_ARGS}.ext.s
		$LINUXDROID_HOST_PLATFORM-as -o ${LINUXDROID_PKG_EXTRA_MAKE_ARGS}.ht.o ${LINUXDROID_PKG_EXTRA_MAKE_ARGS}.ht.s

		# Use -fuse-ld=bfd to avoid using the gold linker (which Linuxdroid
		# patches NDK to use by default) as it causes (tzo), the time
		# zone offset, to always be 0 (and probably other problems):
		$CC -o ../bin/picolisp ${LINUXDROID_PKG_EXTRA_MAKE_ARGS}.base.o \
			-Wl,--no-as-needed -rdynamic -lc -lm -ldl -pie -fuse-ld=bfd
		chmod +x ../bin/picolisp
		$CC -o ../lib/ext -shared -rdynamic -fuse-ld=bfd ${LINUXDROID_PKG_EXTRA_MAKE_ARGS}.ext.o
		$CC -o ../lib/ht -shared -rdynamic -fuse-ld=bfd ${LINUXDROID_PKG_EXTRA_MAKE_ARGS}.ht.o
	fi

	mkdir -p $LINUXDROID_PREFIX/share/man/man1
	cp $LINUXDROID_PKG_SRCDIR/../man/man1/{pil,picolisp}.1 $LINUXDROID_PREFIX/share/man/man1/

	rm -Rf $LINUXDROID_PREFIX/lib/picolisp
	mkdir -p $LINUXDROID_PREFIX/lib/picolisp

	cp -Rf $LINUXDROID_PKG_SRCDIR/../* $LINUXDROID_PREFIX/lib/picolisp/
	rm -Rf $LINUXDROID_PREFIX/lib/picolisp/{src,man,java,ersatz}

	# Replace first line "#!/usr/bin/picolisp /usr/lib/picolisp/lib.l":
	sed -i "1 s|^.*$|#!$LINUXDROID_PREFIX/bin/picolisp $LINUXDROID_PREFIX/lib/picolisp/lib.l|g" $LINUXDROID_PREFIX/lib/picolisp/bin/pil

	( cd $LINUXDROID_PREFIX/bin && ln -f -s ../lib/picolisp/bin/picolisp picolisp && ln -f -s ../lib/picolisp/bin/pil pil )

	# Bundled tools:
	$CC $ORIG_CFLAGS $CPPFLAGS $LDFLAGS -o $LINUXDROID_PREFIX/lib/picolisp/bin/ssl ../src/ssl.c -lssl -lcrypto
	$CC $ORIG_CFLAGS $CPPFLAGS $LDFLAGS -o $LINUXDROID_PREFIX/lib/picolisp/bin/httpGate ../src/httpGate.c -lssl -lcrypto

	# Man pages:
	cp $LINUXDROID_PKG_SRCDIR/../man/man1/{pil,picolisp}.1 $LINUXDROID_PREFIX/share/man/man1/
}

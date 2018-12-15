MININIX_PKG_HOMEPAGE=https://picolisp.com
MININIX_PKG_DESCRIPTION="Lisp interpreter and application server framework"
MININIX_PKG_DEPENDS="libcrypt, openssl"
MININIX_PKG_VERSION=18.9.18
MININIX_PKG_SHA256=aa14a35b7d071c068545d835db74c77538b115b37316dd1b331bd0dee2af0f24
# We use our bintray mirror since old version snapshots are not kept on main site.
MININIX_PKG_SRCURL=https://dl.bintray.com/mininix/upstream/picolisp_${MININIX_PKG_VERSION}.tar.gz
MININIX_PKG_BUILD_IN_SRC=true
# arm and i686: The c code uses gcc-specific "variable length array in structure":
# x86_64: The assembly is not position-independent:
MININIX_PKG_BLACKLISTED_ARCHES="arm, i686, x86_64"

mininix_step_pre_configure() {
	# Validate that we have the right version:
	grep -q "Version ${MININIX_PKG_VERSION//./ }" src64/version.l || {
		mininix_error_exit "Picolisp version needs to be bumped"
	}

	if [ $MININIX_ARCH_BITS = 64 ]; then
		cd $MININIX_PKG_SRCDIR
		if [ $MININIX_ARCH = "aarch64" ]; then
			export MININIX_PKG_EXTRA_MAKE_ARGS=arm64.android
		else
			mininix_error_exit "Unsupported arch: $MININIX_ARCH"
		fi
		MININIX_PKG_SRCDIR=$MININIX_PKG_SRCDIR/src64
	else
		MININIX_PKG_SRCDIR=$MININIX_PKG_SRCDIR/src
	fi
	MININIX_PKG_BUILDDIR=$MININIX_PKG_SRCDIR
	ORIG_CFLAGS="$CFLAGS"
	CFLAGS+=" -c $LDFLAGS $CPPFLAGS"
}

mininix_step_make_install () {
	cd $MININIX_PKG_SRCDIR/

	if [ $MININIX_ARCH_BITS = "64" ]; then
		$MININIX_HOST_PLATFORM-as -o ${MININIX_PKG_EXTRA_MAKE_ARGS}.base.o ${MININIX_PKG_EXTRA_MAKE_ARGS}.base.s
		$MININIX_HOST_PLATFORM-as -o ${MININIX_PKG_EXTRA_MAKE_ARGS}.ext.o ${MININIX_PKG_EXTRA_MAKE_ARGS}.ext.s
		$MININIX_HOST_PLATFORM-as -o ${MININIX_PKG_EXTRA_MAKE_ARGS}.ht.o ${MININIX_PKG_EXTRA_MAKE_ARGS}.ht.s

		# Use -fuse-ld=bfd to avoid using the gold linker (which Mininix
		# patches NDK to use by default) as it causes (tzo), the time
		# zone offset, to always be 0 (and probably other problems):
		$CC -o ../bin/picolisp ${MININIX_PKG_EXTRA_MAKE_ARGS}.base.o \
			-Wl,--no-as-needed -rdynamic -lc -lm -ldl -pie -fuse-ld=bfd
		chmod +x ../bin/picolisp
		$CC -o ../lib/ext -shared -rdynamic -fuse-ld=bfd ${MININIX_PKG_EXTRA_MAKE_ARGS}.ext.o
		$CC -o ../lib/ht -shared -rdynamic -fuse-ld=bfd ${MININIX_PKG_EXTRA_MAKE_ARGS}.ht.o
	fi

	mkdir -p $MININIX_PREFIX/share/man/man1
	cp $MININIX_PKG_SRCDIR/../man/man1/{pil,picolisp}.1 $MININIX_PREFIX/share/man/man1/

	rm -Rf $MININIX_PREFIX/lib/picolisp
	mkdir -p $MININIX_PREFIX/lib/picolisp

	cp -Rf $MININIX_PKG_SRCDIR/../* $MININIX_PREFIX/lib/picolisp/
	rm -Rf $MININIX_PREFIX/lib/picolisp/{src,man,java,ersatz}

	# Replace first line "#!/usr/bin/picolisp /usr/lib/picolisp/lib.l":
	sed -i "1 s|^.*$|#!$MININIX_PREFIX/bin/picolisp $MININIX_PREFIX/lib/picolisp/lib.l|g" $MININIX_PREFIX/lib/picolisp/bin/pil

	( cd $MININIX_PREFIX/bin && ln -f -s ../lib/picolisp/bin/picolisp picolisp && ln -f -s ../lib/picolisp/bin/pil pil )

	# Bundled tools:
	$CC $ORIG_CFLAGS $CPPFLAGS $LDFLAGS -o $MININIX_PREFIX/lib/picolisp/bin/ssl ../src/ssl.c -lssl -lcrypto
	$CC $ORIG_CFLAGS $CPPFLAGS $LDFLAGS -o $MININIX_PREFIX/lib/picolisp/bin/httpGate ../src/httpGate.c -lssl -lcrypto

	# Man pages:
	cp $MININIX_PKG_SRCDIR/../man/man1/{pil,picolisp}.1 $MININIX_PREFIX/share/man/man1/
}

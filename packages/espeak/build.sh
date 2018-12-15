MININIX_PKG_HOMEPAGE=https://github.com/espeak-ng/espeak-ng
MININIX_PKG_DESCRIPTION="Compact software speech synthesizer"
# Use eSpeak NG as the original eSpeak project is dead.
# See https://github.com/espeak-ng/espeak-ng/issues/180
# about cross compilation of espeak-ng.
MININIX_PKG_VERSION=1.49.2
MININIX_PKG_REVISION=1
MININIX_PKG_SHA256=cf7ed86850b99bafe819548c73a6651a74300980dd15f319ff22e2bd72ea20b4
MININIX_PKG_SRCURL=https://github.com/espeak-ng/espeak-ng/releases/download/${MININIX_PKG_VERSION}/espeak-ng-${MININIX_PKG_VERSION}.tar.gz
MININIX_PKG_BUILD_IN_SRC=yes
MININIX_PKG_HOSTBUILD=yes
MININIX_PKG_RM_AFTER_INSTALL="lib/*ng-test*"
# --without-async due to that using pthread_cancel().
MININIX_PKG_EXTRA_CONFIGURE_ARGS="--without-async"

mininix_step_post_extract_package() {
	./autogen.sh
}

mininix_step_host_build() {
	cp -Rf $MININIX_PKG_SRCDIR/* .
	unset MAKEFLAGS
	./configure --prefix=$MININIX_PREFIX
	make -j$MININIX_MAKE_PROCESSES src/{e,}speak-ng

	# Man pages require the ronn ruby program.
	#make src/espeak-ng.1
	#cp src/espeak-ng.1 $MININIX_PREFIX/share/man/man1
	#(cd $MININIX_PREFIX/share/man/man1 && ln -s -f espeak-ng.1 espeak.1)

	make install
}

mininix_step_make() {
	# Prevent caching of host build:
	rm -Rf $MININIX_PKG_HOSTBUILD_DIR
	make -j$MININIX_MAKE_PROCESSES src/{e,}speak-ng
}

mininix_step_make_install() {
	rm $MININIX_PREFIX/bin/{e,}speak{,-ng}
	cp src/.libs/espeak-ng $MININIX_PREFIX/bin/espeak
	cp src/.libs/libespeak-ng.so $MININIX_PREFIX/lib/libespeak-ng.so.1.1.49
}

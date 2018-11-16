LINUXDROID_PKG_HOMEPAGE=https://github.com/espeak-ng/espeak-ng
LINUXDROID_PKG_DESCRIPTION="Compact software speech synthesizer"
# Use eSpeak NG as the original eSpeak project is dead.
# See https://github.com/espeak-ng/espeak-ng/issues/180
# about cross compilation of espeak-ng.
LINUXDROID_PKG_VERSION=1.49.2
LINUXDROID_PKG_REVISION=1
LINUXDROID_PKG_SHA256=cf7ed86850b99bafe819548c73a6651a74300980dd15f319ff22e2bd72ea20b4
LINUXDROID_PKG_SRCURL=https://github.com/espeak-ng/espeak-ng/releases/download/${LINUXDROID_PKG_VERSION}/espeak-ng-${LINUXDROID_PKG_VERSION}.tar.gz
LINUXDROID_PKG_BUILD_IN_SRC=yes
LINUXDROID_PKG_HOSTBUILD=yes
LINUXDROID_PKG_RM_AFTER_INSTALL="lib/*ng-test*"
# --without-async due to that using pthread_cancel().
LINUXDROID_PKG_EXTRA_CONFIGURE_ARGS="--without-async"

linuxdroid_step_host_build() {
	cp -Rf $LINUXDROID_PKG_SRCDIR/* .
	unset MAKEFLAGS
	./configure --prefix=$LINUXDROID_PREFIX
	make -j$LINUXDROID_MAKE_PROCESSES src/{e,}speak-ng

	# Man pages require the ronn ruby program.
	#make src/espeak-ng.1
	#cp src/espeak-ng.1 $LINUXDROID_PREFIX/share/man/man1
	#(cd $LINUXDROID_PREFIX/share/man/man1 && ln -s -f espeak-ng.1 espeak.1)

	make install
}

linuxdroid_step_make() {
	# Prevent caching of host build:
	rm -Rf $LINUXDROID_PKG_HOSTBUILD_DIR
	make -j$LINUXDROID_MAKE_PROCESSES src/{e,}speak-ng
}

linuxdroid_step_make_install() {
	rm $LINUXDROID_PREFIX/bin/{e,}speak{,-ng}
	cp src/.libs/espeak-ng $LINUXDROID_PREFIX/bin/espeak
	cp src/.libs/libespeak-ng.so $LINUXDROID_PREFIX/lib/libespeak-ng.so.1.1.49
}

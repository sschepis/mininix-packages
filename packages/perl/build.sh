LINUXDROID_PKG_HOMEPAGE=https://www.perl.org/
LINUXDROID_PKG_DESCRIPTION="Capable, feature-rich programming language"
LINUXDROID_PKG_VERSION=(5.28.0
		    1.2)
LINUXDROID_PKG_SHA256=(7e929f64d4cb0e9d1159d4a59fc89394e27fa1f7004d0836ca0d514685406ea8
                   599077beb86af5e6097da8922a84474a5484f61475d2899eae0f8634e9619109)
LINUXDROID_PKG_SRCURL=(http://www.cpan.org/src/5.0/perl-${LINUXDROID_PKG_VERSION}.tar.gz
		   https://github.com/arsv/perl-cross/releases/download/${LINUXDROID_PKG_VERSION[1]}/perl-cross-${LINUXDROID_PKG_VERSION[1]}.tar.gz)
LINUXDROID_PKG_BUILD_IN_SRC="yes"
LINUXDROID_MAKE_PROCESSES=1
LINUXDROID_PKG_RM_AFTER_INSTALL="bin/perl${LINUXDROID_PKG_VERSION}"
LINUXDROID_PKG_NO_DEVELSPLIT=yes

linuxdroid_step_post_extract_package () {
	# This port uses perl-cross: http://arsv.github.io/perl-cross/
	cp -rf perl-cross-${LINUXDROID_PKG_VERSION[1]}/* .

	# Remove old installation to force fresh:
	rm -rf $LINUXDROID_PREFIX/lib/perl5
	rm -f $LINUXDROID_PREFIX/lib/libperl.so
	rm -f $LINUXDROID_PREFIX/include/perl
}

linuxdroid_step_configure () {
	export PATH=$PATH:$LINUXDROID_STANDALONE_TOOLCHAIN/bin

	ORIG_AR=$AR; unset AR
	ORIG_AS=$AS; unset AS
	ORIG_CC=$CC; unset CC
	ORIG_CXX=$CXX; unset CXX
	ORIG_CPP=$CPP; unset CPP
	ORIG_CFLAGS=$CFLAGS; unset CFLAGS
	ORIG_CPPFLAGS=$CPPFLAGS; unset CPPFLAGS
	ORIG_CXXFLAGS=$CXXFLAGS; unset CXXFLAGS
	ORIG_LDFLAGS=$LDFLAGS; unset LDFLAGS
	ORIG_RANLIB=$RANLIB; unset RANLIB
	ORIG_LD=$LD; unset LD

	# Since we specify $LINUXDROID_PREFIX/bin/sh below for the shell
	# it will be run during the build, so temporarily (removed in
	# linuxdroid_step_post_make_install below) setup symlink:
	rm -f $LINUXDROID_PREFIX/bin/sh
	ln -s /bin/sh $LINUXDROID_PREFIX/bin/sh

	cd $LINUXDROID_PKG_BUILDDIR
	$LINUXDROID_PKG_SRCDIR/configure \
		--target=$LINUXDROID_HOST_PLATFORM \
		-Dosname=android \
		-Dsysroot=$LINUXDROID_STANDALONE_TOOLCHAIN/sysroot \
		-Dprefix=$LINUXDROID_PREFIX \
		-Dsh=$LINUXDROID_PREFIX/bin/sh \
		-Dcc=$ORIG_CC \
		-Duseshrplib
}

linuxdroid_step_post_make_install () {
	# Replace hardlinks with symlinks:
	cd $LINUXDROID_PREFIX/share/man/man1
	rm perlbug.1
	ln -s perlthanks.1 perlbug.1

	# Cleanup:
	rm $LINUXDROID_PREFIX/bin/sh

	cd $LINUXDROID_PREFIX/lib
	ln -f -s perl5/${LINUXDROID_PKG_VERSION}/${LINUXDROID_ARCH}-android/CORE/libperl.so libperl.so

	cd $LINUXDROID_PREFIX/include
	ln -f -s ../lib/perl5/${LINUXDROID_PKG_VERSION}/${LINUXDROID_ARCH}-android/CORE perl
	cd ../lib/perl5/${LINUXDROID_PKG_VERSION}/${LINUXDROID_ARCH}-android/
	chmod +w Config_heavy.pl
	sed 's',"--sysroot=$LINUXDROID_STANDALONE_TOOLCHAIN"/sysroot,"-I/data/data/com.linuxdroid/files/usr/include",'g' Config_heavy.pl > Config_heavy.pl.new
	sed 's',"$LINUXDROID_STANDALONE_TOOLCHAIN"/sysroot,"-I/data/data/com.linuxdroid/files",'g' Config_heavy.pl.new > Config_heavy.pl
	rm Config_heavy.pl.new
}

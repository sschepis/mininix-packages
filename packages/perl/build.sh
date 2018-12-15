MININIX_PKG_HOMEPAGE=https://www.perl.org/
MININIX_PKG_DESCRIPTION="Capable, feature-rich programming language"
MININIX_PKG_VERSION=(5.28.0
		    1.2)
MININIX_PKG_SHA256=(7e929f64d4cb0e9d1159d4a59fc89394e27fa1f7004d0836ca0d514685406ea8
                   599077beb86af5e6097da8922a84474a5484f61475d2899eae0f8634e9619109)
MININIX_PKG_SRCURL=(http://www.cpan.org/src/5.0/perl-${MININIX_PKG_VERSION}.tar.gz
		   https://github.com/arsv/perl-cross/releases/download/${MININIX_PKG_VERSION[1]}/perl-cross-${MININIX_PKG_VERSION[1]}.tar.gz)
MININIX_PKG_BUILD_IN_SRC="yes"
MININIX_MAKE_PROCESSES=1
MININIX_PKG_RM_AFTER_INSTALL="bin/perl${MININIX_PKG_VERSION}"
MININIX_PKG_NO_DEVELSPLIT=yes

mininix_step_post_extract_package () {
	# This port uses perl-cross: http://arsv.github.io/perl-cross/
	cp -rf perl-cross-${MININIX_PKG_VERSION[1]}/* .

	# Remove old installation to force fresh:
	rm -rf $MININIX_PREFIX/lib/perl5
	rm -f $MININIX_PREFIX/lib/libperl.so
	rm -f $MININIX_PREFIX/include/perl
}

mininix_step_configure () {
	export PATH=$PATH:$MININIX_STANDALONE_TOOLCHAIN/bin

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

	# Since we specify $MININIX_PREFIX/bin/sh below for the shell
	# it will be run during the build, so temporarily (removed in
	# mininix_step_post_make_install below) setup symlink:
	rm -f $MININIX_PREFIX/bin/sh
	ln -s /bin/sh $MININIX_PREFIX/bin/sh

	cd $MININIX_PKG_BUILDDIR
	$MININIX_PKG_SRCDIR/configure \
		--target=$MININIX_HOST_PLATFORM \
		-Dosname=android \
		-Dsysroot=$MININIX_STANDALONE_TOOLCHAIN/sysroot \
		-Dprefix=$MININIX_PREFIX \
		-Dsh=$MININIX_PREFIX/bin/sh \
		-Dcc=$ORIG_CC \
		-Duseshrplib
}

mininix_step_post_make_install () {
	# Replace hardlinks with symlinks:
	cd $MININIX_PREFIX/share/man/man1
	rm perlbug.1
	ln -s perlthanks.1 perlbug.1

	# Cleanup:
	rm $MININIX_PREFIX/bin/sh

	cd $MININIX_PREFIX/lib
	ln -f -s perl5/${MININIX_PKG_VERSION}/${MININIX_ARCH}-android/CORE/libperl.so libperl.so

	cd $MININIX_PREFIX/include
	ln -f -s ../lib/perl5/${MININIX_PKG_VERSION}/${MININIX_ARCH}-android/CORE perl
	cd ../lib/perl5/${MININIX_PKG_VERSION}/${MININIX_ARCH}-android/
	chmod +w Config_heavy.pl
	sed 's',"--sysroot=$MININIX_STANDALONE_TOOLCHAIN"/sysroot,"-I/data/data/com.mininix/files/usr/include",'g' Config_heavy.pl > Config_heavy.pl.new
	sed 's',"$MININIX_STANDALONE_TOOLCHAIN"/sysroot,"-I/data/data/com.mininix/files",'g' Config_heavy.pl.new > Config_heavy.pl
	rm Config_heavy.pl.new
}

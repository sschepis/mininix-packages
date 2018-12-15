MININIX_PKG_HOMEPAGE=http://www.swi-prolog.org/
MININIX_PKG_DESCRIPTION="Comprehensive free Prolog environment"
MININIX_PKG_VERSION=7.3.6
MININIX_PKG_SRCURL=http://www.swi-prolog.org/download/devel/src/swipl-${MININIX_PKG_VERSION}.tar.gz
MININIX_PKG_BUILD_IN_SRC=true
MININIX_PKG_HOSTBUILD=true
MININIX_PKG_DEPENDS="readline, libgmp"

mininix_step_host_build () {
	cp -Rf $MININIX_PKG_SRCDIR/* .

	# apt install libgmp-dev:i386 libncurses5-dev:i386
	./configure --host=i386-linux --disable-readline #--disable-gmp

	if [ $MININIX_ARCH_BITS = 32 ]; then
		# "Make sure that the native swipl has the same word-length (32/64 bits) 
		# and use the native swipl for creating the boot file"
		# https://groups.google.com/forum/#!topic/swi-prolog/8lBcjb9cxuk
		find . -name Makefile | xargs perl -p -i -e 's/CFLAGS=/CFLAGS=-m32 /'
		find . -name Makefile | xargs perl -p -i -e 's/LDFLAGS=/LDFLAGS=-m32 /'
	fi
	make 
}


mininix_step_post_configure () {
	cp $MININIX_PKG_HOSTBUILD_DIR/src/defatom src/
	touch -d "next hour" $MININIX_PKG_BUILDDIR/src/defatom
	#cp $MININIX_PKG_HOSTBUILD_DIR/{defatom,swipl} $MININIX_PKG_BUILDDIR/src/

	#bdir=/home/fornwall/mininix/swi-prolog/src/src
	#PLARCH=arm-linux
	perl -p -i -e "s|bdir=|bdir=$MININIX_PKG_HOSTBUILD_DIR/src/ # |" */swipl.sh
	perl -p -i -e "s|PLARCH=|PLARCH=i386-linux # |" */swipl.sh
	perl -p -i -e "s|${MININIX_ARCH}-linux|i386-linux|" */swipl.sh
}

mininix_step_post_make_install () {
	mv $MININIX_PREFIX/lib/swipl-$MININIX_PKG_VERSION/lib/${MININIX_ARCH}-linux/libswipl.so* $MININIX_PREFIX/lib/
}

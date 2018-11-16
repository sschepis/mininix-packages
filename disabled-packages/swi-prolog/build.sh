LINUXDROID_PKG_HOMEPAGE=http://www.swi-prolog.org/
LINUXDROID_PKG_DESCRIPTION="Comprehensive free Prolog environment"
LINUXDROID_PKG_VERSION=7.3.6
LINUXDROID_PKG_SRCURL=http://www.swi-prolog.org/download/devel/src/swipl-${LINUXDROID_PKG_VERSION}.tar.gz
LINUXDROID_PKG_BUILD_IN_SRC=true
LINUXDROID_PKG_HOSTBUILD=true
LINUXDROID_PKG_DEPENDS="readline, libgmp"

linuxdroid_step_host_build () {
	cp -Rf $LINUXDROID_PKG_SRCDIR/* .

	# apt install libgmp-dev:i386 libncurses5-dev:i386
	./configure --host=i386-linux --disable-readline #--disable-gmp

	if [ $LINUXDROID_ARCH_BITS = 32 ]; then
		# "Make sure that the native swipl has the same word-length (32/64 bits) 
		# and use the native swipl for creating the boot file"
		# https://groups.google.com/forum/#!topic/swi-prolog/8lBcjb9cxuk
		find . -name Makefile | xargs perl -p -i -e 's/CFLAGS=/CFLAGS=-m32 /'
		find . -name Makefile | xargs perl -p -i -e 's/LDFLAGS=/LDFLAGS=-m32 /'
	fi
	make 
}


linuxdroid_step_post_configure () {
	cp $LINUXDROID_PKG_HOSTBUILD_DIR/src/defatom src/
	touch -d "next hour" $LINUXDROID_PKG_BUILDDIR/src/defatom
	#cp $LINUXDROID_PKG_HOSTBUILD_DIR/{defatom,swipl} $LINUXDROID_PKG_BUILDDIR/src/

	#bdir=/home/fornwall/linuxdroid/swi-prolog/src/src
	#PLARCH=arm-linux
	perl -p -i -e "s|bdir=|bdir=$LINUXDROID_PKG_HOSTBUILD_DIR/src/ # |" */swipl.sh
	perl -p -i -e "s|PLARCH=|PLARCH=i386-linux # |" */swipl.sh
	perl -p -i -e "s|${LINUXDROID_ARCH}-linux|i386-linux|" */swipl.sh
}

linuxdroid_step_post_make_install () {
	mv $LINUXDROID_PREFIX/lib/swipl-$LINUXDROID_PKG_VERSION/lib/${LINUXDROID_ARCH}-linux/libswipl.so* $LINUXDROID_PREFIX/lib/
}

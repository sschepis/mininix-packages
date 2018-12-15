MININIX_PKG_HOMEPAGE=http://www.info-zip.org/
MININIX_PKG_DESCRIPTION="Tools for working with zip files"
MININIX_PKG_VERSION=6.0
MININIX_PKG_REVISION=2
MININIX_PKG_SRCURL=https://downloads.sourceforge.net/infozip/unzip60.tar.gz
MININIX_PKG_SHA256=036d96991646d0449ed0aa952e4fbe21b476ce994abc276e49d30e686708bd37
MININIX_PKG_DEPENDS="libandroid-support, libbz2"
MININIX_PKG_BUILD_IN_SRC=yes

mininix_step_configure () {
	cp unix/Makefile Makefile
}

mininix_step_make () {
	LD="$CC $LDFLAGS -lbz2" CC="$CC $CFLAGS $CPPFLAGS $LDFLAGS -DNO_LCHMOD -DUSE_BZIP2" make -j $MININIX_MAKE_PROCESSES generic
}

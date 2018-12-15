MININIX_PKG_HOMEPAGE=http://caca.zoy.org/wiki/libcaca
MININIX_PKG_DESCRIPTION="Graphics library that outputs text instead of pixels"
MININIX_PKG_VERSION=0.99.beta19
MININIX_PKG_REVISION=2
# Switched to mirror on 2014-12-22 since master was down:
MININIX_PKG_SRCURL=http://fossies.org/linux/privat/libcaca-${MININIX_PKG_VERSION}.tar.gz
#                     http://caca.zoy.org/files/libcaca/libcaca-${MININIX_PKG_VERSION}.tar.gz
MININIX_PKG_SHA256=128b467c4ed03264c187405172a4e83049342cc8cc2f655f53a2d0ee9d3772f4
MININIX_PKG_DEPENDS="ncurses"
MININIX_PKG_EXTRA_CONFIGURE_ARGS="--disable-python --disable-java --disable-ruby --disable-doc"

mininix_step_post_configure () {
	if [ $MININIX_ARCH = x86_64 ]; then
		# Remove troublesome asm usage:
		perl -p -i -e 's/#define HAVE_FLDLN2 1//' $MININIX_PKG_BUILDDIR/config.h
	fi
}

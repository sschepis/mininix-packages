MININIX_PKG_HOMEPAGE=https://pngquant.org
MININIX_PKG_DESCRIPTION="PNG image optimising utility"
MININIX_PKG_VERSION=2.12.2
MININIX_PKG_SHA256=(5edf7c5bffd07e5d28fcc6d4d94a187c30b532c52ac986b3e45aff3dce0567dc
                   34036379d3b68de79b5f180b3fe3989b9d2e81c1909ee3f85acaedb74f46003b)
# If both archives are .tar.gz then they overwrite eachother since they are the same version and hence the same name.
# Work around this by using .zip for one of them...
MININIX_PKG_SRCURL=(https://github.com/pornel/pngquant/archive/$MININIX_PKG_VERSION.tar.gz
		   https://github.com/ImageOptim/libimagequant/archive/$MININIX_PKG_VERSION.zip)
MININIX_PKG_DEPENDS="libpng, littlecms"
MININIX_PKG_MAINTAINER="Vishal Biswas @vishalbiswas"
MININIX_PKG_BUILD_IN_SRC=true
MININIX_PKG_EXTRA_CONFIGURE_ARGS="--disable-sse"

mininix_step_post_extract_package () {
	mv $MININIX_PKG_SRCDIR/libimagequant-$MININIX_PKG_VERSION/* $MININIX_PKG_SRCDIR/lib/
}

MININIX_PKG_HOMEPAGE=https://www.freetype.org
MININIX_PKG_DESCRIPTION="Software font engine capable of producing high-quality output"
MININIX_PKG_VERSION=2.9.1
MININIX_PKG_SHA256=db8d87ea720ea9d5edc5388fc7a0497bb11ba9fe972245e0f7f4c7e8b1e1e84d
MININIX_PKG_SRCURL=https://downloads.sourceforge.net/project/freetype/freetype2/${MININIX_PKG_VERSION}/freetype-${MININIX_PKG_VERSION}.tar.bz2
MININIX_PKG_DEPENDS="libbz2, libpng"
MININIX_PKG_REVISION=1
MININIX_PKG_INCLUDE_IN_DEVPACKAGE="bin/freetype-config share/man/man1/freetype-config.1"
# Use with-harfbuzz=no to avoid circular dependency between freetype and harfbuzz:
MININIX_PKG_EXTRA_CONFIGURE_ARGS="--with-harfbuzz=no"
# not install these files anymore so install them manually.
mininix_step_post_make_install () {
	cp freetype-config $MININIX_PREFIX/bin
	cp ../src/docs/freetype-config.1 $MININIX_PREFIX/share/man/man1/
}


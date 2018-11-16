LINUXDROID_PKG_HOMEPAGE=https://www.freetype.org
LINUXDROID_PKG_DESCRIPTION="Software font engine capable of producing high-quality output"
LINUXDROID_PKG_VERSION=2.9.1
LINUXDROID_PKG_SHA256=db8d87ea720ea9d5edc5388fc7a0497bb11ba9fe972245e0f7f4c7e8b1e1e84d
LINUXDROID_PKG_SRCURL=https://downloads.sourceforge.net/project/freetype/freetype2/${LINUXDROID_PKG_VERSION}/freetype-${LINUXDROID_PKG_VERSION}.tar.bz2
LINUXDROID_PKG_DEPENDS="libbz2, libpng"
LINUXDROID_PKG_REVISION=1
LINUXDROID_PKG_INCLUDE_IN_DEVPACKAGE="bin/freetype-config share/man/man1/freetype-config.1"
# Use with-harfbuzz=no to avoid circular dependency between freetype and harfbuzz:
LINUXDROID_PKG_EXTRA_CONFIGURE_ARGS="--with-harfbuzz=no"
# not install these files anymore so install them manually.
linuxdroid_step_post_make_install () {
	cp freetype-config $LINUXDROID_PREFIX/bin
	cp ../src/docs/freetype-config.1 $LINUXDROID_PREFIX/share/man/man1/
}


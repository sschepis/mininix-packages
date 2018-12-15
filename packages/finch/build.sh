MININIX_PKG_HOMEPAGE=https://pidgin.im/
MININIX_PKG_DESCRIPTION="Text-based multi-protocol instant messaging client"
MININIX_PKG_VERSION=2.13.0
MININIX_PKG_SHA256=2747150c6f711146bddd333c496870bfd55058bab22ffb7e4eb784018ec46d8f
MININIX_PKG_SRCURL=http://downloads.sourceforge.net/project/pidgin/Pidgin/${MININIX_PKG_VERSION}/pidgin-${MININIX_PKG_VERSION}.tar.bz2
MININIX_PKG_DEPENDS="libgnutls, libxml2, ncurses-ui-libs, glib"
MININIX_PKG_EXTRA_CONFIGURE_ARGS="
--disable-gtkui
--disable-gstreamer
--disable-vv
--disable-idn
--disable-meanwhile
--disable-avahi
--disable-dbus
--disable-perl
--disable-tcl
--without-zephyr
--with-ncurses-headers=$MININIX_PREFIX/include
--without-python
"
MININIX_PKG_RM_AFTER_INSTALL="share/sounds/purple lib/purple-2/libmsn.so"

mininix_step_pre_configure () {
	# For arpa:
	CFLAGS+=" -isystem $MININIX_PKG_BUILDER_DIR"
}

mininix_step_post_configure () {
        # Hack to compile first version of libpurple-ciphers.la
        cp $MININIX_PREFIX/lib/libxml2.so $MININIX_PREFIX/lib/libpurple.so

        cd $MININIX_PKG_BUILDDIR/libpurple/ciphers
        make libpurple-ciphers.la
        cd ..
        make libpurple.la

        # Put a more proper version in lib:
        cp .libs/libpurple.so $MININIX_PREFIX/lib/

        make clean
}

mininix_step_post_make_install () {
        cd $MININIX_PREFIX/lib
        for lib in jabber oscar ymsg; do
                ln -f -s purple-2/lib${lib}.so .
        done
}

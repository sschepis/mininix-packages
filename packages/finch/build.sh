LINUXDROID_PKG_HOMEPAGE=https://pidgin.im/
LINUXDROID_PKG_DESCRIPTION="Text-based multi-protocol instant messaging client"
LINUXDROID_PKG_VERSION=2.13.0
LINUXDROID_PKG_SHA256=2747150c6f711146bddd333c496870bfd55058bab22ffb7e4eb784018ec46d8f
LINUXDROID_PKG_SRCURL=http://downloads.sourceforge.net/project/pidgin/Pidgin/${LINUXDROID_PKG_VERSION}/pidgin-${LINUXDROID_PKG_VERSION}.tar.bz2
LINUXDROID_PKG_DEPENDS="libgnutls, libxml2, ncurses-ui-libs, glib"
LINUXDROID_PKG_EXTRA_CONFIGURE_ARGS="
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
--with-ncurses-headers=$LINUXDROID_PREFIX/include
--without-python
"
LINUXDROID_PKG_RM_AFTER_INSTALL="share/sounds/purple lib/purple-2/libmsn.so"

linuxdroid_step_pre_configure () {
	# For arpa:
	CFLAGS+=" -isystem $LINUXDROID_PKG_BUILDER_DIR"
}

linuxdroid_step_post_configure () {
        # Hack to compile first version of libpurple-ciphers.la
        cp $LINUXDROID_PREFIX/lib/libxml2.so $LINUXDROID_PREFIX/lib/libpurple.so

        cd $LINUXDROID_PKG_BUILDDIR/libpurple/ciphers
        make libpurple-ciphers.la
        cd ..
        make libpurple.la

        # Put a more proper version in lib:
        cp .libs/libpurple.so $LINUXDROID_PREFIX/lib/

        make clean
}

linuxdroid_step_post_make_install () {
        cd $LINUXDROID_PREFIX/lib
        for lib in jabber oscar ymsg; do
                ln -f -s purple-2/lib${lib}.so .
        done
}

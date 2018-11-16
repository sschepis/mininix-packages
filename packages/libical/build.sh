LINUXDROID_PKG_HOMEPAGE=http://libical.github.io/libical/
LINUXDROID_PKG_DESCRIPTION="Libical is an Open Source implementation of the iCalendar protocols and protocol data units"
LINUXDROID_PKG_VERSION=3.0.4
LINUXDROID_PKG_SHA256=72b216e10233c3f60cb06062facf41f3b0f70615e5a60b47f9853341a0d5d145
LINUXDROID_PKG_SRCURL=https://github.com/libical/libical/releases/download/v$LINUXDROID_PKG_VERSION/libical-$LINUXDROID_PKG_VERSION.tar.gz
LINUXDROID_PKG_DEPENDS="libxml2"
LINUXDROID_PKG_EXTRA_CONFIGURE_ARGS=" -DSHARED_ONLY=true -DICAL_GLIB=false -DUSE_BUILTIN_TZDATA=true -DPERL_EXECUTABLE=/usr/bin/perl"

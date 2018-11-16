LINUXDROID_PKG_HOMEPAGE=http://www.nongnu.org/man-db/
LINUXDROID_PKG_DESCRIPTION="Utilities for examining on-line help files (manual pages)"
LINUXDROID_PKG_VERSION=2.7.5
LINUXDROID_PKG_REVISION=1
LINUXDROID_PKG_SRCURL=http://mirror.csclub.uwaterloo.ca/nongnu/man-db/man-db-${LINUXDROID_PKG_VERSION}.tar.xz
LINUXDROID_PKG_EXTRA_CONFIGURE_ARGS="--with-db=gdbm --with-pager=less --with-config-file=/data/data/com.linuxdroid/files/usr/etc/man_db.conf --disable-setuid --with-browser=lynx --with-gzip=gzip --with-systemdtmpfilesdir=/data/data/com.linuxdroid/files/usr/lib/tmpfiles.d"
LINUXDROID_PKG_DEPENDS="flex, gdbm, groff, less, libandroid-support, libpipeline, lynx"

export GROFF_TMAC_PATH="/data/data/com.linuxdroid/files/usr/lib/groff/site-tmac:/data/data/com.linuxdroid/files/usr/share/groff/site-tmac:/data/data/com.linuxdroid/files/usr/share/groff/current/tmac"

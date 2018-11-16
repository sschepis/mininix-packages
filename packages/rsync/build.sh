LINUXDROID_PKG_HOMEPAGE=https://rsync.samba.org/
LINUXDROID_PKG_DESCRIPTION="Utility that provides fast incremental file transfer"
LINUXDROID_PKG_VERSION=3.1.3
LINUXDROID_PKG_REVISION=1
LINUXDROID_PKG_SHA256=55cc554efec5fdaad70de921cd5a5eeb6c29a95524c715f3bbf849235b0800c0
LINUXDROID_PKG_SRCURL=https://rsync.samba.org/ftp/rsync/src/rsync-${LINUXDROID_PKG_VERSION}.tar.gz
LINUXDROID_PKG_EXTRA_CONFIGURE_ARGS="--with-rsyncd-conf=$LINUXDROID_PREFIX/etc/rsyncd.conf --with-included-zlib=no --disable-debug"
LINUXDROID_PKG_DEPENDS="libpopt, openssh | dropbear"

linuxdroid_step_pre_configure () {
	CFLAGS="$CFLAGS -llog" # for syslog
}

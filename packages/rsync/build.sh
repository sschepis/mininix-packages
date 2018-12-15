MININIX_PKG_HOMEPAGE=https://rsync.samba.org/
MININIX_PKG_DESCRIPTION="Utility that provides fast incremental file transfer"
MININIX_PKG_VERSION=3.1.3
MININIX_PKG_REVISION=1
MININIX_PKG_SHA256=55cc554efec5fdaad70de921cd5a5eeb6c29a95524c715f3bbf849235b0800c0
MININIX_PKG_SRCURL=https://rsync.samba.org/ftp/rsync/src/rsync-${MININIX_PKG_VERSION}.tar.gz
MININIX_PKG_EXTRA_CONFIGURE_ARGS="--with-rsyncd-conf=$MININIX_PREFIX/etc/rsyncd.conf --with-included-zlib=no --disable-debug"
MININIX_PKG_DEPENDS="libpopt, openssh | dropbear"

mininix_step_pre_configure () {
	CFLAGS="$CFLAGS -llog" # for syslog
}

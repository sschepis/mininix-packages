LINUXDROID_PKG_HOMEPAGE=http://man7.org/linux/man-pages/man5/resolv.conf.5.html
LINUXDROID_PKG_DESCRIPTION="Resolver configuration file"
LINUXDROID_PKG_VERSION=1.1

linuxdroid_step_make_install () {
	_RESOLV_CONF=$LINUXDROID_PREFIX/etc/resolv.conf
	printf "nameserver 8.8.8.8\nnameserver 8.8.4.4" > $_RESOLV_CONF
}

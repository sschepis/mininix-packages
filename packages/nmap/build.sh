LINUXDROID_PKG_HOMEPAGE=https://nmap.org/
LINUXDROID_PKG_DESCRIPTION="Utility for network discovery and security auditing"
LINUXDROID_PKG_VERSION=7.70
LINUXDROID_PKG_REVISION=2
LINUXDROID_PKG_SHA256=847b068955f792f4cc247593aca6dc3dc4aae12976169873247488de147a6e18
LINUXDROID_PKG_SRCURL=https://nmap.org/dist/nmap-${LINUXDROID_PKG_VERSION}.tar.bz2
# Depend on netcat so that it gets installed automatically when installing
# nmap, since the ncat program is usually distributed as part of nmap.
LINUXDROID_PKG_DEPENDS="libpcap, pcre, openssl, resolv-conf, netcat, liblua, libssh2"
# --without-nmap-update to avoid linking against libsvn_client:
# --without-zenmap to avoid python scripts for graphical gtk frontend:
# --without-ndiff to avoid python2-using ndiff utility:
LINUXDROID_PKG_EXTRA_CONFIGURE_ARGS="--enable-static --with-liblua=$LINUXDROID_PREFIX --without-nmap-update --without-zenmap --without-ndiff"
LINUXDROID_PKG_BUILD_IN_SRC="yes"

linuxdroid_step_post_make_install () {
	# Setup 'netcat' and 'nc' as symlink to 'ncat', since the other netcat implementations
	# are outdated (gnu-netcat) or non-portable (openbsd-netcat).
	for prog in netcat nc; do
		cd $LINUXDROID_PREFIX/bin
		ln -s -f ncat $prog
		cd $LINUXDROID_PREFIX/share/man/man1
		ln -s -f ncat.1 ${prog}.1
	done
}

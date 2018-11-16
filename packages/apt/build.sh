LINUXDROID_PKG_HOMEPAGE=https://packages.debian.org/apt
LINUXDROID_PKG_DESCRIPTION="Front-end for the dpkg package manager"
LINUXDROID_PKG_DEPENDS="libcurl, liblzma, dpkg, gpgv, libc++, linuxdroid-exec"
LINUXDROID_PKG_VERSION=1.4.8
LINUXDROID_PKG_REVISION=6
LINUXDROID_PKG_SHA256=767ad7d6efb64cde52faececb7d3c0bf49800b9fe06f3a5b0132ab4c01a5b8f8
LINUXDROID_PKG_SRCURL=http://ftp.debian.org/debian/pool/main/a/apt/apt_${LINUXDROID_PKG_VERSION}.tar.xz
LINUXDROID_PKG_EXTRA_CONFIGURE_ARGS="
-DPERL_EXECUTABLE=`which perl`
-DCMAKE_INSTALL_FULL_LOCALSTATEDIR=$LINUXDROID_PREFIX
-DCOMMON_ARCH=$LINUXDROID_ARCH
-DDPKG_DATADIR=$LINUXDROID_PREFIX/share/dpkg
-DUSE_NLS=OFF
-DWITH_DOC=OFF
"
LINUXDROID_PKG_ESSENTIAL=yes
LINUXDROID_PKG_CONFFILES="etc/apt/sources.list etc/apt/trusted.gpg"
LINUXDROID_PKG_CONFLICTS=apt-transport-https
LINUXDROID_PKG_REPLACES=apt-transport-https
LINUXDROID_PKG_RM_AFTER_INSTALL="
bin/apt-cdrom
bin/apt-extracttemplates
bin/apt-sortpkgs
etc/apt/apt.conf.d
lib/apt/apt-helper
lib/apt/methods/bzip2
lib/apt/methods/cdrom
lib/apt/methods/mirror
lib/apt/methods/rred
lib/apt/planners/
lib/apt/solvers/
lib/dpkg/
lib/libapt-inst.so
"

linuxdroid_step_post_make_install() {
	printf "# The main linuxdroid repository:\ndeb https://linuxdroid.net stable main\n" > $LINUXDROID_PREFIX/etc/apt/sources.list
	cp $LINUXDROID_PKG_BUILDER_DIR/trusted.gpg $LINUXDROID_PREFIX/etc/apt/
	rm $LINUXDROID_PREFIX/include/apt-pkg -r

	# apt-transport-tor
	ln -sfr $LINUXDROID_PREFIX/lib/apt/methods/http $LINUXDROID_PREFIX/lib/apt/methods/tor
	ln -sfr $LINUXDROID_PREFIX/lib/apt/methods/http $LINUXDROID_PREFIX/lib/apt/methods/tor+http
	ln -sfr $LINUXDROID_PREFIX/lib/apt/methods/https $LINUXDROID_PREFIX/lib/apt/methods/tor+https
}

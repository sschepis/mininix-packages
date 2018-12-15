MININIX_PKG_HOMEPAGE=https://packages.debian.org/apt
MININIX_PKG_DESCRIPTION="Front-end for the dpkg package manager"
MININIX_PKG_DEPENDS="libcurl, liblzma, dpkg, gpgv, libc++, mininix-exec"
MININIX_PKG_VERSION=1.4.8
MININIX_PKG_REVISION=7
MININIX_PKG_SHA256=767ad7d6efb64cde52faececb7d3c0bf49800b9fe06f3a5b0132ab4c01a5b8f8
MININIX_PKG_SRCURL=http://ftp.debian.org/debian/pool/main/a/apt/apt_${MININIX_PKG_VERSION}.tar.xz
MININIX_PKG_EXTRA_CONFIGURE_ARGS="
-DPERL_EXECUTABLE=`which perl`
-DCMAKE_INSTALL_FULL_LOCALSTATEDIR=$MININIX_PREFIX
-DCOMMON_ARCH=$MININIX_ARCH
-DDPKG_DATADIR=$MININIX_PREFIX/share/dpkg
-DUSE_NLS=OFF
-DWITH_DOC=OFF
"
MININIX_PKG_ESSENTIAL=yes
MININIX_PKG_CONFFILES="etc/apt/sources.list etc/apt/trusted.gpg"
MININIX_PKG_CONFLICTS=apt-transport-https
MININIX_PKG_REPLACES=apt-transport-https
MININIX_PKG_RM_AFTER_INSTALL="
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

mininix_step_post_make_install() {
	printf "# The main mininix repository:\ndeb https://mininix.net stable main\n" > $MININIX_PREFIX/etc/apt/sources.list
	cp $MININIX_PKG_BUILDER_DIR/trusted.gpg $MININIX_PREFIX/etc/apt/
	rm $MININIX_PREFIX/include/apt-pkg -r

	# apt-transport-tor
	ln -sfr $MININIX_PREFIX/lib/apt/methods/http $MININIX_PREFIX/lib/apt/methods/tor
	ln -sfr $MININIX_PREFIX/lib/apt/methods/http $MININIX_PREFIX/lib/apt/methods/tor+http
	ln -sfr $MININIX_PREFIX/lib/apt/methods/https $MININIX_PREFIX/lib/apt/methods/tor+https
}

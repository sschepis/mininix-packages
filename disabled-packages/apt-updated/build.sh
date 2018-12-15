MININIX_PKG_HOMEPAGE=https://packages.debian.org/apt
MININIX_PKG_DESCRIPTION="Front-end for the dpkg package manager"
MININIX_PKG_DEPENDS="libutil, libcurl, liblzma, dpkg, gpgv, libc++"
MININIX_PKG_VERSION=1.6~alpha3
MININIX_PKG_SHA256=2acd561ff04fc3efa4c590139ca60cfdbc93787ea80334f7448ecf466faab119
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
MININIX_PKG_CONFFILES="etc/apt/sources.list"
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
	printf "# The main mininix repository:\ndeb [arch=all,${MININIX_ARCH}] https://mininix.net stable main\n" > $MININIX_PREFIX/etc/apt/sources.list
        cp $MININIX_PKG_BUILDER_DIR/trusted.gpg $MININIX_PREFIX/etc/apt/
	rm /data/data/com.mininix/files/usr/include/apt-pkg -r
}

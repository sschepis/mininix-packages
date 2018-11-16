LINUXDROID_PKG_HOMEPAGE=https://packages.debian.org/apt
LINUXDROID_PKG_DESCRIPTION="Front-end for the dpkg package manager"
LINUXDROID_PKG_DEPENDS="libutil, libcurl, liblzma, dpkg, gpgv, libc++"
LINUXDROID_PKG_VERSION=1.6~alpha3
LINUXDROID_PKG_SHA256=2acd561ff04fc3efa4c590139ca60cfdbc93787ea80334f7448ecf466faab119
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
LINUXDROID_PKG_CONFFILES="etc/apt/sources.list"
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
	printf "# The main linuxdroid repository:\ndeb [arch=all,${LINUXDROID_ARCH}] https://linuxdroid.net stable main\n" > $LINUXDROID_PREFIX/etc/apt/sources.list
        cp $LINUXDROID_PKG_BUILDER_DIR/trusted.gpg $LINUXDROID_PREFIX/etc/apt/
	rm /data/data/com.linuxdroid/files/usr/include/apt-pkg -r
}

LINUXDROID_PKG_HOMEPAGE=https://www.gnu.org/software/libidn/
LINUXDROID_PKG_DESCRIPTION="GNU Libidn library, implementation of IETF IDN specifications"
LINUXDROID_PKG_VERSION=1.35
LINUXDROID_PKG_SHA256=f11af1005b46b7b15d057d7f107315a1ad46935c7fcdf243c16e46ec14f0fe1e
LINUXDROID_PKG_SRCURL=https://mirrors.kernel.org/gnu/libidn/libidn-${LINUXDROID_PKG_VERSION}.tar.gz
# Remove the idn tool for now, add it as subpackage if desired::
LINUXDROID_PKG_RM_AFTER_INSTALL="bin/idn share/man/man1/idn.1 share/emacs"
LINUXDROID_PKG_EXTRA_CONFIGURE_ARGS="--disable-ld-version-script"

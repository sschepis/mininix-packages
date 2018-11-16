LINUXDROID_PKG_HOMEPAGE=https://xapian.org
LINUXDROID_PKG_DESCRIPTION="Xapian search engine library"
LINUXDROID_PKG_VERSION=1.4.9
LINUXDROID_PKG_SHA256=cde9c39d014f04c09b59d9c21551db9794c10617dc69ab4c9826352a533df5cc
LINUXDROID_PKG_SRCURL=http://oligarchy.co.uk/xapian/${LINUXDROID_PKG_VERSION}/xapian-core-${LINUXDROID_PKG_VERSION}.tar.xz
# Note that we cannot /proc/sys/kernel/random/uuid (permission denied on
# new android versions) so need libuuid.
LINUXDROID_PKG_DEPENDS="libuuid"
LINUXDROID_PKG_INCLUDE_IN_DEVPACKAGE="bin/xapian-config share/man/man1/xapian-config.1"

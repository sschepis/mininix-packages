LINUXDROID_PKG_HOMEPAGE=https://github.com/adrianlopezroche/fdupes
LINUXDROID_PKG_DESCRIPTION="Duplicates file detector"
LINUXDROID_PKG_VERSION=1.6.1
LINUXDROID_PKG_SRCURL=https://github.com/adrianlopezroche/fdupes/archive/v${LINUXDROID_PKG_VERSION}.tar.gz
LINUXDROID_PKG_SHA256=9d6b6fdb0b8419815b4df3bdfd0aebc135b8276c90bbbe78ebe6af0b88ba49ea
LINUXDROID_PKG_BUILD_IN_SRC=yes

linuxdroid_step_configure() {
    sed -i "s,PREFIX = /usr/local,PREFIX = ${LINUXDROID_PREFIX}," "$LINUXDROID_PKG_SRCDIR/Makefile"
}


MININIX_PKG_HOMEPAGE=https://github.com/adrianlopezroche/fdupes
MININIX_PKG_DESCRIPTION="Duplicates file detector"
MININIX_PKG_VERSION=1.6.1
MININIX_PKG_SRCURL=https://github.com/adrianlopezroche/fdupes/archive/v${MININIX_PKG_VERSION}.tar.gz
MININIX_PKG_SHA256=9d6b6fdb0b8419815b4df3bdfd0aebc135b8276c90bbbe78ebe6af0b88ba49ea
MININIX_PKG_BUILD_IN_SRC=yes

mininix_step_configure() {
    sed -i "s,PREFIX = /usr/local,PREFIX = ${MININIX_PREFIX}," "$MININIX_PKG_SRCDIR/Makefile"
}


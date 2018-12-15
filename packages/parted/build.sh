MININIX_PKG_HOMEPAGE=https://www.gnu.org/software/parted/
MININIX_PKG_DESCRIPTION="Versatile partition editor"
MININIX_PKG_VERSION=3.2
MININIX_PKG_SRCURL=https://ftp.gnu.org/gnu/parted/parted-${MININIX_PKG_VERSION}.tar.xz
MININIX_PKG_SHA256=858b589c22297cacdf437f3baff6f04b333087521ab274f7ab677cb8c6bb78e4
MININIX_PKG_DEPENDS="libuuid, readline"
MININIX_PKG_EXTRA_CONFIGURE_ARGS="
--disable-device-mapper
"

mininix_step_pre_configure () {
    CFLAGS+=" -Wno-gnu-designator"
}

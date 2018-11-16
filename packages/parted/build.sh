LINUXDROID_PKG_HOMEPAGE=https://www.gnu.org/software/parted/
LINUXDROID_PKG_DESCRIPTION="Versatile partition editor"
LINUXDROID_PKG_VERSION=3.2
LINUXDROID_PKG_SRCURL=https://ftp.gnu.org/gnu/parted/parted-${LINUXDROID_PKG_VERSION}.tar.xz
LINUXDROID_PKG_SHA256=858b589c22297cacdf437f3baff6f04b333087521ab274f7ab677cb8c6bb78e4
LINUXDROID_PKG_DEPENDS="libuuid, readline"
LINUXDROID_PKG_EXTRA_CONFIGURE_ARGS="
--disable-device-mapper
"

linuxdroid_step_pre_configure () {
    CFLAGS+=" -Wno-gnu-designator"
}

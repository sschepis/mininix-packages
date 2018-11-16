LINUXDROID_PKG_HOMEPAGE=http://www.ltrace.org/
LINUXDROID_PKG_DESCRIPTION="Tracks runtime library calls in dynamically linked programs"
LINUXDROID_PKG_VERSION=0.7.3.20160411
LINUXDROID_PKG_REVISION=3
LINUXDROID_PKG_DEPENDS="libelf"
local _COMMIT=2def9f1217374cc8371105993003b2c663aefda7
LINUXDROID_PKG_SRCURL=https://github.com/dkogan/ltrace/archive/${_COMMIT}.zip
LINUXDROID_PKG_SHA256=d089ae8affd8af782c12aed7ba97f44c7f55b60033ec78ab07e415e7b091a90c
LINUXDROID_PKG_EXTRA_CONFIGURE_ARGS="
--disable-werror
--without-libunwind
ac_cv_host=$LINUXDROID_ARCH-generic-linux-gnu
"

linuxdroid_step_pre_configure () {
	# rindex is an obsolete version of strrchr which is not available in Android:
	CFLAGS+=" -Drindex=strrchr"
	if [ "$LINUXDROID_ARCH" == "arm" ]; then
		CFLAGS+=" -DSHT_ARM_ATTRIBUTES=0x70000000+3"
	fi

	autoreconf -i ../src
}

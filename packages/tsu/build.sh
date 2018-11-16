LINUXDROID_PKG_HOMEPAGE=https://github.com/cswl/tsu
LINUXDROID_PKG_DESCRIPTION="A su wrapper for Linuxdroid"
LINUXDROID_PKG_VERSION=2.0
LINUXDROID_PKG_PLATFORM_INDEPENDENT=yes
LINUXDROID_PKG_SRCURL=https://github.com/cswl/tsu/archive/ce32547e7ca441ed449b12447539da959b889e95.zip
LINUXDROID_PKG_SHA256=11c0b0c0b1c9acb64d354ce9b0348d3d950e06e274d567498b1b46e8fd51fb9e
LINUXDROID_PKG_BUILD_IN_SRC=yes

linuxdroid_step_make() {
	:
}

linuxdroid_step_make_install () {
	cp tsu $LINUXDROID_PREFIX/bin/tsu
	chmod +x $LINUXDROID_PREFIX/bin/tsu

	cp tsudo $LINUXDROID_PREFIX/bin/tsudo
	chmod +x $LINUXDROID_PREFIX/bin/tsudo
}

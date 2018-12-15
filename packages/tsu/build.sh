MININIX_PKG_HOMEPAGE=https://github.com/cswl/tsu
MININIX_PKG_DESCRIPTION="A su wrapper for Mininix"
MININIX_PKG_VERSION=2.0
MININIX_PKG_PLATFORM_INDEPENDENT=yes
MININIX_PKG_SRCURL=https://github.com/cswl/tsu/archive/ce32547e7ca441ed449b12447539da959b889e95.zip
MININIX_PKG_SHA256=11c0b0c0b1c9acb64d354ce9b0348d3d950e06e274d567498b1b46e8fd51fb9e
MININIX_PKG_BUILD_IN_SRC=yes

mininix_step_make() {
	:
}

mininix_step_make_install () {
	cp tsu $MININIX_PREFIX/bin/tsu
	chmod +x $MININIX_PREFIX/bin/tsu

	cp tsudo $MININIX_PREFIX/bin/tsudo
	chmod +x $MININIX_PREFIX/bin/tsudo
}

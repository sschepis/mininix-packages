MININIX_PKG_HOMEPAGE=https://github.com/mininix/mininix-create-package
MININIX_PKG_DESCRIPTION="Utility to create Mininix packages"
MININIX_PKG_VERSION=0.7
MININIX_PKG_SHA256=e318edf152b01b19306b9f591104e50c6131f08db50694aa16ddade196400f5f
MININIX_PKG_SRCURL=https://github.com/mininix/mininix-create-package/archive/v${MININIX_PKG_VERSION}.tar.gz
MININIX_PKG_DEPENDS="python"
MININIX_PKG_BUILD_IN_SRC=yes
MININIX_PKG_PLATFORM_INDEPENDENT=yes

mininix_step_make_install () {
	cp mininix-create-package $MININIX_PREFIX/bin/mininix-create-package
}

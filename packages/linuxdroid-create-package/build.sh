LINUXDROID_PKG_HOMEPAGE=https://github.com/linuxdroid/linuxdroid-create-package
LINUXDROID_PKG_DESCRIPTION="Utility to create Linuxdroid packages"
LINUXDROID_PKG_VERSION=0.7
LINUXDROID_PKG_SHA256=e318edf152b01b19306b9f591104e50c6131f08db50694aa16ddade196400f5f
LINUXDROID_PKG_SRCURL=https://github.com/linuxdroid/linuxdroid-create-package/archive/v${LINUXDROID_PKG_VERSION}.tar.gz
LINUXDROID_PKG_DEPENDS="python"
LINUXDROID_PKG_BUILD_IN_SRC=yes
LINUXDROID_PKG_PLATFORM_INDEPENDENT=yes

linuxdroid_step_make_install () {
	cp linuxdroid-create-package $LINUXDROID_PREFIX/bin/linuxdroid-create-package
}

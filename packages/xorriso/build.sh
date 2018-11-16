LINUXDROID_PKG_HOMEPAGE=https://www.gnu.org/software/xorriso
LINUXDROID_PKG_DESCRIPTION="Tool for creating ISO files."
LINUXDROID_PKG_VERSION=1.5.0
LINUXDROID_PKG_SHA256=a93fa7ae5bb1902198cddfec25201388156932f36f2f5da829bf4fcae9a6062b
LINUXDROID_PKG_SRCURL=https://www.gnu.org/software/xorriso/xorriso-${LINUXDROID_PKG_VERSION}.tar.gz
LINUXDROID_PKG_DEPENDS="libandroid-support, readline, libbz2"
LINUXDROID_PKG_BUILD_IN_SRC=yes
LINUXDROID_PKG_EXTRA_CONFIGURE_ARGS="--disable-jtethreads"

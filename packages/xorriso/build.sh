MININIX_PKG_HOMEPAGE=https://www.gnu.org/software/xorriso
MININIX_PKG_DESCRIPTION="Tool for creating ISO files."
MININIX_PKG_VERSION=1.5.0
MININIX_PKG_SHA256=a93fa7ae5bb1902198cddfec25201388156932f36f2f5da829bf4fcae9a6062b
MININIX_PKG_SRCURL=https://www.gnu.org/software/xorriso/xorriso-${MININIX_PKG_VERSION}.tar.gz
MININIX_PKG_DEPENDS="libandroid-support, readline, libbz2"
MININIX_PKG_BUILD_IN_SRC=yes
MININIX_PKG_EXTRA_CONFIGURE_ARGS="--disable-jtethreads"

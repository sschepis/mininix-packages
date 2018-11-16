LINUXDROID_PKG_HOMEPAGE=https://www.passwordstore.org
LINUXDROID_PKG_DESCRIPTION="Lightweight directory-based password manager"
LINUXDROID_PKG_VERSION=1.7.3
LINUXDROID_PKG_SHA256=2b6c65846ebace9a15a118503dcd31b6440949a30d3b5291dfb5b1615b99a3f4
LINUXDROID_PKG_SRCURL=https://git.zx2c4.com/password-store/snapshot/password-store-${LINUXDROID_PKG_VERSION}.tar.xz
LINUXDROID_PKG_BUILD_IN_SRC=yes
# Depend on coreutils as pass uses [:graph:] when calling tr, which busybox tr does not support:
LINUXDROID_PKG_DEPENDS="bash, gnupg (>= 2.2.9-1), tree, coreutils"
LINUXDROID_PKG_RECOMMENDS="git"
LINUXDROID_PKG_SUGGESTS="pass-otp"
LINUXDROID_PKG_PLATFORM_INDEPENDENT=yes

MININIX_PKG_HOMEPAGE=https://www.passwordstore.org
MININIX_PKG_DESCRIPTION="Lightweight directory-based password manager"
MININIX_PKG_VERSION=1.7.3
MININIX_PKG_SHA256=2b6c65846ebace9a15a118503dcd31b6440949a30d3b5291dfb5b1615b99a3f4
MININIX_PKG_SRCURL=https://git.zx2c4.com/password-store/snapshot/password-store-${MININIX_PKG_VERSION}.tar.xz
MININIX_PKG_BUILD_IN_SRC=yes
# Depend on coreutils as pass uses [:graph:] when calling tr, which busybox tr does not support:
MININIX_PKG_DEPENDS="bash, gnupg (>= 2.2.9-1), tree, coreutils"
MININIX_PKG_RECOMMENDS="git"
MININIX_PKG_SUGGESTS="pass-otp"
MININIX_PKG_PLATFORM_INDEPENDENT=yes

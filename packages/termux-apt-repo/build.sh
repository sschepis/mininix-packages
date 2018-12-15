MININIX_PKG_HOMEPAGE=https://github.com/mininix/mininix-apt-repo
MININIX_PKG_DESCRIPTION="Script to create Mininix apt repositories"
MININIX_PKG_VERSION=0.3
MININIX_PKG_SHA256=8b3d7d22cb413ecf8ac3f3b86897a104d11c7d1c95ad8ebc0fbea44add866779
MININIX_PKG_SRCURL=https://github.com/mininix/mininix-apt-repo/archive/v${MININIX_PKG_VERSION}.tar.gz
MININIX_PKG_BUILD_IN_SRC=yes
MININIX_PKG_PLATFORM_INDEPENDENT=yes
# binutils for ar:
MININIX_PKG_DEPENDS="binutils, python, tar"

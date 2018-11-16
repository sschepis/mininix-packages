LINUXDROID_PKG_HOMEPAGE=https://github.com/linuxdroid/linuxdroid-apt-repo
LINUXDROID_PKG_DESCRIPTION="Script to create Linuxdroid apt repositories"
LINUXDROID_PKG_VERSION=0.3
LINUXDROID_PKG_SHA256=8b3d7d22cb413ecf8ac3f3b86897a104d11c7d1c95ad8ebc0fbea44add866779
LINUXDROID_PKG_SRCURL=https://github.com/linuxdroid/linuxdroid-apt-repo/archive/v${LINUXDROID_PKG_VERSION}.tar.gz
LINUXDROID_PKG_BUILD_IN_SRC=yes
LINUXDROID_PKG_PLATFORM_INDEPENDENT=yes
# binutils for ar:
LINUXDROID_PKG_DEPENDS="binutils, python, tar"

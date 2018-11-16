LINUXDROID_PKG_HOMEPAGE=https://www.gnupg.org/related_software/libassuan/
LINUXDROID_PKG_DESCRIPTION="Library implementing the Assuan IPC protocol used between most newer GnuPG components"
LINUXDROID_PKG_VERSION=2.5.1
LINUXDROID_PKG_SHA256=47f96c37b4f2aac289f0bc1bacfa8bd8b4b209a488d3d15e2229cb6cc9b26449
LINUXDROID_PKG_SRCURL=https://www.gnupg.org/ftp/gcrypt/libassuan/libassuan-${LINUXDROID_PKG_VERSION}.tar.bz2
LINUXDROID_PKG_INCLUDE_IN_DEVPACKAGE="bin/libassuan-config"
LINUXDROID_PKG_DEPENDS="libgpg-error"

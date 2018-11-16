LINUXDROID_PKG_HOMEPAGE=https://www.gnu.org/software/wget/
LINUXDROID_PKG_DESCRIPTION="Commandline tool for retrieving files using HTTP, HTTPS and FTP"
LINUXDROID_PKG_VERSION=1.19.5
LINUXDROID_PKG_REVISION=1
LINUXDROID_PKG_SHA256=29fbe6f3d5408430c572a63fe32bd43d5860f32691173dfd84edc06869edca75
LINUXDROID_PKG_SRCURL=https://mirrors.kernel.org/gnu/wget/wget-${LINUXDROID_PKG_VERSION}.tar.lz
LINUXDROID_PKG_DEPENDS="pcre, openssl, libuuid, libandroid-support, libunistring"
LINUXDROID_PKG_EXTRA_CONFIGURE_ARGS="--with-ssl=openssl --disable-iri"

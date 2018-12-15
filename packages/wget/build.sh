MININIX_PKG_HOMEPAGE=https://www.gnu.org/software/wget/
MININIX_PKG_DESCRIPTION="Commandline tool for retrieving files using HTTP, HTTPS and FTP"
MININIX_PKG_VERSION=1.19.5
MININIX_PKG_REVISION=1
MININIX_PKG_SHA256=29fbe6f3d5408430c572a63fe32bd43d5860f32691173dfd84edc06869edca75
MININIX_PKG_SRCURL=https://mirrors.kernel.org/gnu/wget/wget-${MININIX_PKG_VERSION}.tar.lz
MININIX_PKG_DEPENDS="pcre, openssl, libuuid, libandroid-support, libunistring"
MININIX_PKG_EXTRA_CONFIGURE_ARGS="--with-ssl=openssl --disable-iri"

MININIX_PKG_HOMEPAGE=https://www.agwa.name/projects/git-crypt/
MININIX_PKG_DESCRIPTION="git-crypt enables transparent encryption and decryption of files in a git repository."
MININIX_PKG_VERSION=0.6.0
MININIX_PKG_MAINTAINER="@jottr"
MININIX_PKG_SHA256=777c0c7aadbbc758b69aff1339ca61697011ef7b92f1d1ee9518a8ee7702bb78
MININIX_PKG_SRCURL="https://github.com/AGWA/git-crypt/archive/${MININIX_PKG_VERSION}.tar.gz"
MININIX_PKG_EXTRA_CONFIGURE_ARGS=" -DCMAKE_BUILD_TYPE=Release -Dbuild_parse=yes -Dbuild_xmlparser=yes"
MININIX_PKG_EXTRA_MAKE_ARGS="make ENABLE_MAN=yes"
MININIX_PKG_DEPENDS="git, openssl"

mininix_step_make () {
	cd $MININIX_PKG_SRCDIR
	make
}

mininix_step_make_install () {
	cd $MININIX_PKG_SRCDIR
	make install
}

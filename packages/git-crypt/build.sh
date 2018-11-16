LINUXDROID_PKG_HOMEPAGE=https://www.agwa.name/projects/git-crypt/
LINUXDROID_PKG_DESCRIPTION="git-crypt enables transparent encryption and decryption of files in a git repository."
LINUXDROID_PKG_VERSION=0.6.0
LINUXDROID_PKG_MAINTAINER="@jottr"
LINUXDROID_PKG_SHA256=777c0c7aadbbc758b69aff1339ca61697011ef7b92f1d1ee9518a8ee7702bb78
LINUXDROID_PKG_SRCURL="https://github.com/AGWA/git-crypt/archive/${LINUXDROID_PKG_VERSION}.tar.gz"
LINUXDROID_PKG_EXTRA_CONFIGURE_ARGS=" -DCMAKE_BUILD_TYPE=Release -Dbuild_parse=yes -Dbuild_xmlparser=yes"
LINUXDROID_PKG_EXTRA_MAKE_ARGS="make ENABLE_MAN=yes"
LINUXDROID_PKG_DEPENDS="git, openssl"

linuxdroid_step_make () {
	cd $LINUXDROID_PKG_SRCDIR
	make
}

linuxdroid_step_make_install () {
	cd $LINUXDROID_PKG_SRCDIR
	make install
}

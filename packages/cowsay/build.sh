MININIX_PKG_HOMEPAGE=https://en.wikipedia.org/wiki/Cowsay
MININIX_PKG_DESCRIPTION="Program which generates ASCII pictures of a cow with a message"
MININIX_PKG_VERSION=3.04
MININIX_PKG_SRCURL=http://http.debian.net/debian/pool/main/c/cowsay/cowsay_3.03+dfsg1.orig.tar.gz
MININIX_PKG_SHA256=10bae895d9afb2d720d2211db58f396352b00fe1386c369ca3608cbf6497b839
MININIX_PKG_DEPENDS="perl"
MININIX_PKG_PLATFORM_INDEPENDENT=yes

mininix_step_make_install () {
	cd $MININIX_PKG_SRCDIR
	sh install.sh
}

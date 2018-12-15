MININIX_PKG_HOMEPAGE=http://www.figlet.org/
MININIX_PKG_DESCRIPTION="Program for making large letters out of ordinary text"
MININIX_PKG_VERSION=2.2.5
MININIX_PKG_REVISION=1
MININIX_PKG_SRCURL=ftp://ftp.figlet.org/pub/figlet/program/unix/figlet-${MININIX_PKG_VERSION}.tar.gz
MININIX_PKG_SHA256=bf88c40fd0f077dab2712f54f8d39ac952e4e9f2e1882f1195be9e5e4257417d
MININIX_PKG_BUILD_IN_SRC=yes

mininix_step_pre_configure () {
	LD=$CC
}

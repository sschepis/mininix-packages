LINUXDROID_PKG_HOMEPAGE=http://www.figlet.org/
LINUXDROID_PKG_DESCRIPTION="Program for making large letters out of ordinary text"
LINUXDROID_PKG_VERSION=2.2.5
LINUXDROID_PKG_REVISION=1
LINUXDROID_PKG_SRCURL=ftp://ftp.figlet.org/pub/figlet/program/unix/figlet-${LINUXDROID_PKG_VERSION}.tar.gz
LINUXDROID_PKG_SHA256=bf88c40fd0f077dab2712f54f8d39ac952e4e9f2e1882f1195be9e5e4257417d
LINUXDROID_PKG_BUILD_IN_SRC=yes

linuxdroid_step_pre_configure () {
	LD=$CC
}

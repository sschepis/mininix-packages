MININIX_PKG_HOMEPAGE=http://scripts.sil.org/teckitdownloads
MININIX_PKG_DESCRIPTION="TECkit is a library for encoding conversion"
MININIX_PKG_MAINTAINER="Henrik Grimler @Grimler91"
MININIX_PKG_VERSION=2.5.8
MININIX_PKG_SHA256=0ea52b1304f430aaebff99fec355bc7e4ad75b16ba58959fae5079627f925f93
MININIX_PKG_SRCURL=https://github.com/silnrsi/teckit/archive/v$MININIX_PKG_VERSION.tar.gz
MININIX_PKG_EXTRA_CONFIGURE_ARGS="ac_cv_lib_expat_XML_ExpatVersion=no"

mininix_step_pre_configure() {
	./autogen.sh
}

LINUXDROID_PKG_HOMEPAGE=https://sourceforge.net/projects/soxr/
LINUXDROID_PKG_DESCRIPTION="High quality, one-dimensional sample-rate conversion library"
LINUXDROID_PKG_VERSION=0.1.3
LINUXDROID_PKG_SHA256=b111c15fdc8c029989330ff559184198c161100a59312f5dc19ddeb9b5a15889
LINUXDROID_PKG_SRCURL=https://sourceforge.net/projects/soxr/files/soxr-$LINUXDROID_PKG_VERSION-Source.tar.xz
LINUXDROID_PKG_BUILD_IN_SRC=yes

linuxdroid_step_configure() {
	return 0
}

linuxdroid_step_make() {
	linuxdroid_setup_cmake
	./go
}

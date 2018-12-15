MININIX_PKG_HOMEPAGE=https://sourceforge.net/projects/soxr/
MININIX_PKG_DESCRIPTION="High quality, one-dimensional sample-rate conversion library"
MININIX_PKG_VERSION=0.1.3
MININIX_PKG_SHA256=b111c15fdc8c029989330ff559184198c161100a59312f5dc19ddeb9b5a15889
MININIX_PKG_SRCURL=https://sourceforge.net/projects/soxr/files/soxr-$MININIX_PKG_VERSION-Source.tar.xz
MININIX_PKG_BUILD_IN_SRC=yes

mininix_step_configure() {
	return 0
}

mininix_step_make() {
	mininix_setup_cmake
	./go
}

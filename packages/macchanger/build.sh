MININIX_PKG_HOMEPAGE=https://github.com/alobbs/macchanger
MININIX_PKG_DESCRIPTION="Utility that makes the maniputation of MAC addresses of network interfaces easier"
MININIX_PKG_VERSION=1.7.0
MININIX_PKG_SRCURL=https://github.com/alobbs/macchanger/archive/${MININIX_PKG_VERSION}.tar.gz
MININIX_PKG_SHA256=1d75c07a626321e07b48a5fe2dbefbdb98c3038bb8230923ba8d32bda5726e4f

mininix_step_pre_configure() {
	./autogen.sh
}

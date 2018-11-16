LINUXDROID_PKG_HOMEPAGE=https://github.com/alobbs/macchanger
LINUXDROID_PKG_DESCRIPTION="Utility that makes the maniputation of MAC addresses of network interfaces easier"
LINUXDROID_PKG_VERSION=1.7.0
LINUXDROID_PKG_SRCURL=https://github.com/alobbs/macchanger/archive/${LINUXDROID_PKG_VERSION}.tar.gz
LINUXDROID_PKG_SHA256=1d75c07a626321e07b48a5fe2dbefbdb98c3038bb8230923ba8d32bda5726e4f

linuxdroid_step_pre_configure() {
	./autogen.sh
}

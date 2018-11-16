LINUXDROID_PKG_HOMEPAGE=https://libuv.org
LINUXDROID_PKG_DESCRIPTION="Support library with a focus on asynchronous I/O"
LINUXDROID_PKG_VERSION=1.23.2
LINUXDROID_PKG_SHA256=8ab472ed816bb70c147ddbdfa7b9becfa10921df8a03faf2c87a54eac642c355
LINUXDROID_PKG_SRCURL=https://dist.libuv.org/dist/v${LINUXDROID_PKG_VERSION}/libuv-v${LINUXDROID_PKG_VERSION}.tar.gz

linuxdroid_step_pre_configure () {
	export PLATFORM=android
	sh autogen.sh
}

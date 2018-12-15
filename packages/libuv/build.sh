MININIX_PKG_HOMEPAGE=https://libuv.org
MININIX_PKG_DESCRIPTION="Support library with a focus on asynchronous I/O"
MININIX_PKG_VERSION=1.24.0
MININIX_PKG_SHA256=380532974a82a9d4dbc9ab3863922edd08aa6f03fcae79e3a5bda2ecf407ef06
MININIX_PKG_SRCURL=https://dist.libuv.org/dist/v${MININIX_PKG_VERSION}/libuv-v${MININIX_PKG_VERSION}.tar.gz

mininix_step_pre_configure () {
	export PLATFORM=android
	sh autogen.sh
}

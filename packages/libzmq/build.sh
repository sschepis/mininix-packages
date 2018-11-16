LINUXDROID_PKG_HOMEPAGE=http://zeromq.org/
LINUXDROID_PKG_DESCRIPTION="Fast messaging system built on sockets. C and C++ bindings. aka 0MQ, ZMQ."
LINUXDROID_PKG_VERSION=4.2.5
LINUXDROID_PKG_REVISION=1
LINUXDROID_PKG_SHA256=cc9090ba35713d59bb2f7d7965f877036c49c5558ea0c290b0dcc6f2a17e489f
LINUXDROID_PKG_SRCURL=https://github.com/zeromq/libzmq/releases/download/v${LINUXDROID_PKG_VERSION}/zeromq-${LINUXDROID_PKG_VERSION}.tar.gz
LINUXDROID_PKG_DEPENDS="libsodium"
LINUXDROID_PKG_EXTRA_CONFIGURE_ARGS="--with-libsodium --disable-libunwind --disable-Werror"

linuxdroid_step_post_extract_package() {
	./autogen.sh
}

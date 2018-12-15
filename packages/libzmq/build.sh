MININIX_PKG_HOMEPAGE=http://zeromq.org/
MININIX_PKG_DESCRIPTION="Fast messaging system built on sockets. C and C++ bindings. aka 0MQ, ZMQ."
MININIX_PKG_VERSION=4.2.5
MININIX_PKG_REVISION=1
MININIX_PKG_SHA256=cc9090ba35713d59bb2f7d7965f877036c49c5558ea0c290b0dcc6f2a17e489f
MININIX_PKG_SRCURL=https://github.com/zeromq/libzmq/releases/download/v${MININIX_PKG_VERSION}/zeromq-${MININIX_PKG_VERSION}.tar.gz
MININIX_PKG_DEPENDS="libsodium"
MININIX_PKG_EXTRA_CONFIGURE_ARGS="--with-libsodium --disable-libunwind --disable-Werror"

mininix_step_post_extract_package() {
	./autogen.sh
}

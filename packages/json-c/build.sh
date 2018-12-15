MININIX_PKG_HOMEPAGE=https://github.com/json-c/json-c/wiki
MININIX_PKG_DESCRIPTION="A JSON implementation in C"
MININIX_PKG_MAINTAINER="Balazs Kutil @balazs_kutil"
MININIX_PKG_VERSION=0.13.1
MININIX_PKG_SHA256=b87e608d4d3f7bfdd36ef78d56d53c74e66ab278d318b71e6002a369d36f4873
MININIX_PKG_SRCURL=https://s3.amazonaws.com/json-c_releases/releases/json-c-${MININIX_PKG_VERSION}.tar.gz

mininix_step_make () {
	make \
		LDFLAGS="$LDFLAGS -llog"
}

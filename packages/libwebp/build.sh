MININIX_PKG_HOMEPAGE=https://github.com/webmproject/libwebp
MININIX_PKG_DESCRIPTION="Library to encode and decode images in WebP format"
MININIX_PKG_VERSION=1.0.1
MININIX_PKG_SHA256=c2838544d4898a4bbb6c1d113e0aa50c4bdfc886df0dcfbfa5c42e788cb6f382
MININIX_PKG_SRCURL=https://github.com/webmproject/libwebp/archive/v$MININIX_PKG_VERSION.tar.gz
MININIX_PKG_EXTRA_CONFIGURE_ARGS="
--disable-gif
--disable-jpeg
--disable-libwebpdemux
--disable-png
--disable-tiff
--disable-wic
"
MININIX_PKG_RM_AFTER_INSTALL="share/man/man1"

mininix_step_pre_configure() {
	./autogen.sh
}

LINUXDROID_PKG_HOMEPAGE=https://github.com/webmproject/libwebp
LINUXDROID_PKG_DESCRIPTION="Library to encode and decode images in WebP format"
LINUXDROID_PKG_VERSION=1.0.0
LINUXDROID_PKG_SHA256=c5c5ebf979543ac1f3348df8f6245262abd787a147b9632c880d92bfc38dbbeb
LINUXDROID_PKG_SRCURL=https://github.com/webmproject/libwebp/archive/v$LINUXDROID_PKG_VERSION.tar.gz
LINUXDROID_PKG_EXTRA_CONFIGURE_ARGS="
--disable-gif
--disable-jpeg
--disable-libwebpdemux
--disable-png
--disable-tiff
--disable-wic
"
LINUXDROID_PKG_RM_AFTER_INSTALL="share/man/man1"

linuxdroid_step_pre_configure() {
	./autogen.sh
}

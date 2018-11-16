LINUXDROID_PKG_HOMEPAGE=http://spruce.sourceforge.net/gmime/
LINUXDROID_PKG_DESCRIPTION="MIME message parser and creator"
LINUXDROID_PKG_VERSION=3.2.2
LINUXDROID_PKG_SHA256=613014ffcd327b3f6b06aa45cf4bf3adc25cd831f14537c4132880022dda7209
LINUXDROID_PKG_SRCURL=https://download.gnome.org/sources/gmime/${LINUXDROID_PKG_VERSION:0:3}/gmime-${LINUXDROID_PKG_VERSION}.tar.xz
LINUXDROID_PKG_DEPENDS="glib, libidn2"
LINUXDROID_PKG_EXTRA_CONFIGURE_ARGS="
ac_cv_have_iconv_detect_h=yes
--disable-glibtest
--disable-crypto
"

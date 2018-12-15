MININIX_PKG_HOMEPAGE=http://spruce.sourceforge.net/gmime/
MININIX_PKG_DESCRIPTION="MIME message parser and creator"
MININIX_PKG_VERSION=3.2.3
MININIX_PKG_SHA256=6a0875eeb552ab447dd54853a68ced62217d863631048737dd97eaa2713e7311
MININIX_PKG_SRCURL=https://download.gnome.org/sources/gmime/${MININIX_PKG_VERSION:0:3}/gmime-${MININIX_PKG_VERSION}.tar.xz
MININIX_PKG_DEPENDS="glib, libidn2"
MININIX_PKG_EXTRA_CONFIGURE_ARGS="
ac_cv_have_iconv_detect_h=yes
--disable-glibtest
--disable-crypto
"

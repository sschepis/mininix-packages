MININIX_PKG_HOMEPAGE=http://gegl.org/babl/
MININIX_PKG_DESCRIPTION="Dynamic pixel format translation library"
MININIX_PKG_VERSION=0.1.60
MININIX_PKG_SHA256=1850e024b8972404cae04809e00c7392501b6f14c1b00c65d8128592e021dd1a
MININIX_PKG_SRCURL=https://github.com/GNOME/babl/archive/BABL_${MININIX_PKG_VERSION//./_}.tar.gz

mininix_step_pre_configure() {
	NOCONFIGURE=1 ./autogen.sh
}

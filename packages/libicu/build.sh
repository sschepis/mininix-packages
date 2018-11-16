LINUXDROID_PKG_HOMEPAGE=http://site.icu-project.org/home
LINUXDROID_PKG_DESCRIPTION='International Components for Unicode library'
LINUXDROID_PKG_VERSION=63.1
LINUXDROID_PKG_SHA256=150a1e278fbc5a2ae77aa2efdfb87dcd43321390fe211158192049baaba799b0
LINUXDROID_PKG_SRCURL=https://fossies.org/linux/misc/icu4c-${LINUXDROID_PKG_VERSION//./_}-src.tar.xz
LINUXDROID_PKG_INCLUDE_IN_DEVPACKAGE="bin/icu-config share/man/man1/icu-config.1 lib/icu share/icu"
LINUXDROID_PKG_HOSTBUILD=true
LINUXDROID_PKG_EXTRA_HOSTBUILD_CONFIGURE_ARGS="--disable-samples --disable-tests"
LINUXDROID_PKG_EXTRA_CONFIGURE_ARGS="--disable-samples --disable-tests --with-cross-build=$LINUXDROID_PKG_HOSTBUILD_DIR"
LINUXDROID_PKG_MAINTAINER='Vishal Biswas @vishalbiswas'

linuxdroid_step_post_extract_package() {
	LINUXDROID_PKG_SRCDIR+="/source"
}

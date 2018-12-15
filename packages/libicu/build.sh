MININIX_PKG_HOMEPAGE=http://site.icu-project.org/home
MININIX_PKG_DESCRIPTION='International Components for Unicode library'
MININIX_PKG_VERSION=63.1
MININIX_PKG_SHA256=150a1e278fbc5a2ae77aa2efdfb87dcd43321390fe211158192049baaba799b0
MININIX_PKG_SRCURL=https://fossies.org/linux/misc/icu4c-${MININIX_PKG_VERSION//./_}-src.tar.xz
MININIX_PKG_INCLUDE_IN_DEVPACKAGE="bin/icu-config share/man/man1/icu-config.1 lib/icu share/icu"
MININIX_PKG_HOSTBUILD=true
MININIX_PKG_EXTRA_HOSTBUILD_CONFIGURE_ARGS="--disable-samples --disable-tests"
MININIX_PKG_EXTRA_CONFIGURE_ARGS="--disable-samples --disable-tests --with-cross-build=$MININIX_PKG_HOSTBUILD_DIR"
MININIX_PKG_MAINTAINER='Vishal Biswas @vishalbiswas'

mininix_step_post_extract_package() {
	MININIX_PKG_SRCDIR+="/source"
}

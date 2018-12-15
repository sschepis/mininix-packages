MININIX_PKG_HOMEPAGE=https://github.com/westes/flex
MININIX_PKG_DESCRIPTION="Fast lexical analyser generator"
MININIX_PKG_VERSION=2.6.4
MININIX_PKG_SRCURL=https://github.com/westes/flex/releases/download/v${MININIX_PKG_VERSION}/flex-${MININIX_PKG_VERSION}.tar.gz
MININIX_PKG_SHA256=e87aae032bf07c26f85ac0ed3250998c37621d95f8bd748b31f15b33c45ee995
MININIX_PKG_DEPENDS="m4"
MININIX_PKG_HOSTBUILD=true
MININIX_PKG_EXTRA_CONFIGURE_ARGS+="ac_cv_path_M4=$MININIX_PREFIX/bin/m4"
MININIX_PKG_NO_DEVELSPLIT=yes
MININIX_PKG_CONFLICTS="flex-dev"
MININIX_PKG_REPLACES="flex-dev"

# Work around https://github.com/westes/flex/issues/241 when building
# under ubuntu 17.10:
MININIX_PKG_EXTRA_HOSTBUILD_CONFIGURE_ARGS="CFLAGS=-D_GNU_SOURCE=1"

mininix_step_pre_configure() {
	mkdir -p $MININIX_PKG_BUILDDIR/src/
	cp $MININIX_PKG_HOSTBUILD_DIR/src/stage1flex $MININIX_PKG_BUILDDIR/src/stage1flex
	touch -d "next hour" $MININIX_PKG_BUILDDIR/src/stage1flex
}

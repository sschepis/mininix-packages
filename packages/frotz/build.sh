MININIX_PKG_HOMEPAGE=https://github.com/DavidGriffith/frotz
MININIX_PKG_DESCRIPTION="Interpreter for Infocom and other Z-machine interactive fiction (IF) games"
# frotz does not depend on dialog or curl, but the zgames script we bundle below in mininix_step_make_install() do.
MININIX_PKG_DEPENDS="ncurses, dialog, curl"
MININIX_PKG_VERSION=2.44
MININIX_PKG_REVISION=1
MININIX_PKG_SRCURL=https://github.com/DavidGriffith/frotz/archive/${MININIX_PKG_VERSION}.tar.gz
MININIX_PKG_SHA256=dbb5eb3bc95275dcb984c4bdbaea58bc1f1b085b20092ce6e86d9f0bf3ba858f
MININIX_PKG_BUILD_IN_SRC=yes

mininix_step_pre_configure() {
	# Pull request submitted to replace rindex() with strrchr() at
	# https://github.com/DavidGriffith/frotz/pull/20
	CFLAGS+=" -Drindex=strrchr"
}

mininix_step_make () {
	CC="$CC $CFLAGS $CPPFLAGS $LDFLAGS" PREFIX=$MININIX_PREFIX make -j $MININIX_MAKE_PROCESSES install
}

mininix_step_make_install () {
	cp $MININIX_PKG_BUILDER_DIR/zgames $MININIX_PREFIX/bin/zgames
	chmod +x $MININIX_PREFIX/bin/zgames
}

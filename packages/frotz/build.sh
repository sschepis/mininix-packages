LINUXDROID_PKG_HOMEPAGE=https://github.com/DavidGriffith/frotz
LINUXDROID_PKG_DESCRIPTION="Interpreter for Infocom and other Z-machine interactive fiction (IF) games"
# frotz does not depend on dialog or curl, but the zgames script we bundle below in linuxdroid_step_make_install() do.
LINUXDROID_PKG_DEPENDS="ncurses, dialog, curl"
LINUXDROID_PKG_VERSION=2.44
LINUXDROID_PKG_REVISION=1
LINUXDROID_PKG_SRCURL=https://github.com/DavidGriffith/frotz/archive/${LINUXDROID_PKG_VERSION}.tar.gz
LINUXDROID_PKG_SHA256=dbb5eb3bc95275dcb984c4bdbaea58bc1f1b085b20092ce6e86d9f0bf3ba858f
LINUXDROID_PKG_BUILD_IN_SRC=yes

linuxdroid_step_pre_configure() {
	# Pull request submitted to replace rindex() with strrchr() at
	# https://github.com/DavidGriffith/frotz/pull/20
	CFLAGS+=" -Drindex=strrchr"
}

linuxdroid_step_make () {
	CC="$CC $CFLAGS $CPPFLAGS $LDFLAGS" PREFIX=$LINUXDROID_PREFIX make -j $LINUXDROID_MAKE_PROCESSES install
}

linuxdroid_step_make_install () {
	cp $LINUXDROID_PKG_BUILDER_DIR/zgames $LINUXDROID_PREFIX/bin/zgames
	chmod +x $LINUXDROID_PREFIX/bin/zgames
}

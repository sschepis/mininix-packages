MININIX_PKG_HOMEPAGE=https://tiswww.case.edu/php/chet/readline/rltop.html
MININIX_PKG_DESCRIPTION="Library that allow users to edit command lines as they are typed in"
MININIX_PKG_DEPENDS="libandroid-support, ncurses"
_MAIN_VERSION=7.0
_PATCH_VERSION=5
MININIX_PKG_REVISION=1
MININIX_PKG_SHA256=750d437185286f40a369e1e4f4764eda932b9459b5ec9a731628393dd3d32334
MININIX_PKG_VERSION=${_MAIN_VERSION}.${_PATCH_VERSION}
MININIX_PKG_SRCURL=https://mirrors.kernel.org/gnu/readline/readline-${_MAIN_VERSION}.tar.gz
MININIX_PKG_EXTRA_CONFIGURE_ARGS="--with-curses --enable-multibyte bash_cv_wcwidth_broken=no"
MININIX_PKG_EXTRA_MAKE_ARGS="SHLIB_LIBS=-lncursesw"
MININIX_PKG_CONFFILES="etc/inputrc"

mininix_step_pre_configure () {
	local PATCH_CHECKSUMS
	PATCH_CHECKSUMS[1]=9ac1b3ac2ec7b1bf0709af047f2d7d2a34ccde353684e57c6b47ebca77d7a376
	PATCH_CHECKSUMS[2]=8747c92c35d5db32eae99af66f17b384abaca961653e185677f9c9a571ed2d58
	PATCH_CHECKSUMS[3]=9e43aa93378c7e9f7001d8174b1beb948deefa6799b6f581673f465b7d9d4780
	PATCH_CHECKSUMS[4]=f925683429f20973c552bff6702c74c58c2a38ff6e5cf305a8e847119c5a6b64
	PATCH_CHECKSUMS[5]=ca159c83706541c6bbe39129a33d63bbd76ac594303f67e4d35678711c51b753
	for patch_number in `seq -f '%03g' ${_PATCH_VERSION}`; do
		PATCHFILE=$MININIX_PKG_CACHEDIR/readline_patch_${patch_number}.patch
		mininix_download \
			"https://mirrors.kernel.org/gnu/readline/readline-7.0-patches/readline70-$patch_number" \
			$PATCHFILE \
			${PATCH_CHECKSUMS[patch_number]}
		patch -p0 -i $PATCHFILE
	done

	CFLAGS+=" -fexceptions"
}

mininix_step_post_make_install() {
	mkdir -p $MININIX_PREFIX/lib/pkgconfig
	cp readline.pc $MININIX_PREFIX/lib/pkgconfig/

	mkdir -p $MININIX_PREFIX/etc
	cp $MININIX_PKG_BUILDER_DIR/inputrc $MININIX_PREFIX/etc/
}

LINUXDROID_PKG_HOMEPAGE=https://ctags.io/
LINUXDROID_PKG_DESCRIPTION="Universal ctags: Source code index builder"
LINUXDROID_PKG_VERSION=0.0.20180830
local _COMMIT=f9bbb35e7b4b053f04a1b6f0c2bbcea55641b2b6
LINUXDROID_PKG_SHA256=3585f1b9df43d7ecf31c06877fb7bfed4429a47fe95a8ab65da5738e76a442aa
LINUXDROID_PKG_SRCURL=https://github.com/universal-ctags/ctags/archive/${_COMMIT}.zip
LINUXDROID_PKG_EXTRA_CONFIGURE_ARGS="--enable-tmpdir=$LINUXDROID_PREFIX/tmp"
LINUXDROID_PKG_BUILD_IN_SRC="yes"

linuxdroid_step_pre_configure() {
	export regcomp_works=yes
	./autogen.sh
}

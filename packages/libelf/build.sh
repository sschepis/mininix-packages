MININIX_PKG_HOMEPAGE=https://sourceware.org/elfutils/
MININIX_PKG_DESCRIPTION="ELF object file access library"
# NOTE: We only build the libelf part of elfutils for now,
# as other parts are not clang compatible.
MININIX_PKG_VERSION=0.175
MININIX_PKG_SHA256=f7ef925541ee32c6d15ae5cb27da5f119e01a5ccdbe9fe57bf836730d7b7a65b
MININIX_PKG_SRCURL=ftp://sourceware.org/pub/elfutils/${MININIX_PKG_VERSION}/elfutils-${MININIX_PKG_VERSION}.tar.bz2
# libandroid-support for langinfo.
MININIX_PKG_DEPENDS="libandroid-support"
MININIX_PKG_BUILD_DEPENDS="argp"
MININIX_PKG_EXTRA_CONFIGURE_ARGS="ac_cv_c99=yes --disable-symbol-versioning"
MININIX_PKG_CONFLICTS=elfutils
MININIX_PKG_REPLACES=elfutils

mininix_step_pre_configure() {
	CFLAGS+=" -Wno-error=unused-value -Wno-error=format-nonliteral -Wno-error"

	# Exposes ACCESSPERMS in <sys/stat.h> which elfutils uses:
	CFLAGS+=" -D__USE_BSD"

	CFLAGS+=" -DFNM_EXTMATCH=0"

	cp $MININIX_PKG_BUILDER_DIR/error.h .
	cp $MININIX_PKG_BUILDER_DIR/stdio_ext.h .
	cp $MININIX_PKG_BUILDER_DIR/obstack.h .
	cp $MININIX_PKG_BUILDER_DIR/qsort_r.h .
}

mininix_step_make() {
	make -j $MININIX_MAKE_PROCESSES -C lib
	make -j $MININIX_MAKE_PROCESSES -C libelf
}

mininix_step_make_install() {
	make -j $MININIX_MAKE_PROCESSES -C libelf install
}

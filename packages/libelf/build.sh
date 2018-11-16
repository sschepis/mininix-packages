LINUXDROID_PKG_HOMEPAGE=https://sourceware.org/elfutils/
LINUXDROID_PKG_DESCRIPTION="ELF object file access library"
# NOTE: We only build the libelf part of elfutils for now,
# as other parts are not clang compatible.
LINUXDROID_PKG_VERSION=0.174
LINUXDROID_PKG_SHA256=cdf27e70076e10a29539d89e367101d516bc4aa11b0d7777fe52139e3fcad08a
LINUXDROID_PKG_SRCURL=ftp://sourceware.org/pub/elfutils/${LINUXDROID_PKG_VERSION}/elfutils-${LINUXDROID_PKG_VERSION}.tar.bz2
# libandroid-support for langinfo.
LINUXDROID_PKG_DEPENDS="libandroid-support"
LINUXDROID_PKG_BUILD_DEPENDS="argp"
LINUXDROID_PKG_EXTRA_CONFIGURE_ARGS="ac_cv_c99=yes --disable-symbol-versioning"
LINUXDROID_PKG_CONFLICTS=elfutils
LINUXDROID_PKG_REPLACES=elfutils

linuxdroid_step_pre_configure() {
	CFLAGS+=" -Wno-error=unused-value -Wno-error=format-nonliteral -Wno-error"

	# Exposes ACCESSPERMS in <sys/stat.h> which elfutils uses:
	CFLAGS+=" -D__USE_BSD"

	CFLAGS+=" -DFNM_EXTMATCH=0"

	cp $LINUXDROID_PKG_BUILDER_DIR/error.h .
	cp $LINUXDROID_PKG_BUILDER_DIR/stdio_ext.h .
	cp $LINUXDROID_PKG_BUILDER_DIR/obstack.h .
	cp $LINUXDROID_PKG_BUILDER_DIR/qsort_r.h .
}

linuxdroid_step_make() {
	make -j $LINUXDROID_MAKE_PROCESSES -C lib
	make -j $LINUXDROID_MAKE_PROCESSES -C libelf
}

linuxdroid_step_make_install() {
	make -j $LINUXDROID_MAKE_PROCESSES -C libelf install
}

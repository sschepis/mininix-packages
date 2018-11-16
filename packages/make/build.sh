LINUXDROID_PKG_HOMEPAGE=https://www.gnu.org/software/make/
LINUXDROID_PKG_DESCRIPTION="Tool to control the generation of non-source files from source files"
LINUXDROID_PKG_VERSION=4.2.1
LINUXDROID_PKG_REVISION=2
LINUXDROID_PKG_SHA256=e40b8f018c1da64edd1cc9a6fce5fa63b2e707e404e20cad91fbae337c98a5b7
LINUXDROID_PKG_SRCURL=https://mirrors.kernel.org/gnu/make/make-${LINUXDROID_PKG_VERSION}.tar.gz
# Prevent linking against libelf:
LINUXDROID_PKG_EXTRA_CONFIGURE_ARGS="ac_cv_lib_elf_elf_begin=no"

linuxdroid_step_pre_configure() {
    if [ "$LINUXDROID_ARCH" = arm ]; then
        # Fix issue with make on arm hanging at least under cmake:
        # https://github.com/linuxdroid/linuxdroid-packages/issues/2983
        LINUXDROID_PKG_EXTRA_CONFIGURE_ARGS+=" ac_cv_func_pselect=no"
    fi
}

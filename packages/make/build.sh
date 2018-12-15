MININIX_PKG_HOMEPAGE=https://www.gnu.org/software/make/
MININIX_PKG_DESCRIPTION="Tool to control the generation of non-source files from source files"
MININIX_PKG_VERSION=4.2.1
MININIX_PKG_REVISION=2
MININIX_PKG_SHA256=e40b8f018c1da64edd1cc9a6fce5fa63b2e707e404e20cad91fbae337c98a5b7
MININIX_PKG_SRCURL=https://mirrors.kernel.org/gnu/make/make-${MININIX_PKG_VERSION}.tar.gz
# Prevent linking against libelf:
MININIX_PKG_EXTRA_CONFIGURE_ARGS="ac_cv_lib_elf_elf_begin=no"

mininix_step_pre_configure() {
    if [ "$MININIX_ARCH" = arm ]; then
        # Fix issue with make on arm hanging at least under cmake:
        # https://github.com/mininix/mininix-packages/issues/2983
        MININIX_PKG_EXTRA_CONFIGURE_ARGS+=" ac_cv_func_pselect=no"
    fi
}

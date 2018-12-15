MININIX_PKG_HOMEPAGE=https://www.gnu.org/software/indent/
MININIX_PKG_DESCRIPTION="C language source code formatting program"
MININIX_PKG_VERSION=2.2.12
MININIX_PKG_SHA256=b745a5dfc68f86a483d7f96dc1cda7aafd1e78ecba3c7d8ad304709e91e1defb
MININIX_PKG_SRCURL=http://mirrors.kernel.org/gnu/indent/indent-$MININIX_PKG_VERSION.tar.xz
MININIX_PKG_DEPENDS="libandroid-support"
MININIX_PKG_EXTRA_CONFIGURE_ARGS="ac_cv_func_setlocale=no"
MININIX_PKG_RM_AFTER_INSTALL="bin/texinfo2man"

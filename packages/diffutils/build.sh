MININIX_PKG_HOMEPAGE=https://www.gnu.org/software/diffutils/
MININIX_PKG_DESCRIPTION="Programs (cmp, diff, diff3 and sdiff) related to finding differences between files"
MININIX_PKG_VERSION=3.6
MININIX_PKG_REVISION=1
MININIX_PKG_SRCURL=https://mirrors.kernel.org/gnu/diffutils/diffutils-${MININIX_PKG_VERSION}.tar.xz
MININIX_PKG_SHA256=d621e8bdd4b573918c8145f7ae61817d1be9deb4c8d2328a65cea8e11d783bd6
MININIX_PKG_EXTRA_CONFIGURE_ARGS="ac_cv_path_PR_PROGRAM=${MININIX_PREFIX}/bin/pr"

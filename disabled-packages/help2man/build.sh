# Build fails in docker image, install-info needed there:
#   build-aux/missing: 81: build-aux/missing: install-info: not found
#   WARNING: 'install-info' is missing on your system.
MININIX_PKG_HOMEPAGE=https://www.gnu.org/software/help2man/             
MININIX_PKG_DESCRIPTION="tool for automatically generating simple manual pages from program output."  
MININIX_PKG_VERSION=1.47.5
MININIX_PKG_SHA256=7ca60b2519fdbe97f463fe2df66a6188d18b514bfd44127d985f0234ee2461b1
MININIX_PKG_SRCURL=http://mirrors.kernel.org/gnu/help2man/help2man-${MININIX_PKG_VERSION}.tar.xz
MININIX_PKG_BUILD_IN_SRC=yes

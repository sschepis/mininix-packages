# Disabled due to source download failing.

# using a snapshot tarball because blogc-0.13.0 is not ready for release yet
# (documentation updates pending), but it is already useful and stable enough

MININIX_PKG_HOMEPAGE=https://blogc.rgm.io/
MININIX_PKG_DESCRIPTION="A blog compiler"
MININIX_PKG_VERSION=0.12.0.123.acf1
MININIX_PKG_REVISION=1
MININIX_PKG_MAINTAINER="Rafael Martins @rafaelmartins"
MININIX_PKG_SRCURL="https://travis-distfiles.rgm.io/blogc/blogc-0.12.0.123-acf1/blogc-0.12.0.123-acf1.tar.xz"
MININIX_PKG_SHA256=c1885fd8d0068cb24fda899a236591af9daf492aec3601690e7d9a7badf97616
MININIX_PKG_EXTRA_CONFIGURE_ARGS="--disable-git-receiver --enable-make --enable-runserver --disable-tests --disable-valgrind"

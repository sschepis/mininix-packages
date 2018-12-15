MININIX_PKG_HOMEPAGE=https://www.gnu.org/s/rcs
MININIX_PKG_DESCRIPTION="The GNU Revision Control System
 The Revision Control System (RCS) manages multiple
 revisions of files. RCS automates the storing, retrieval,
 logging, identification, and merging of revisions. RCS is
 useful for text that is revised frequently, for example
 programs, documentation, graphics, papers, and form letters."
MININIX_PKG_VERSION=5.9.4
MININIX_PKG_REVISION=2
MININIX_PKG_SRCURL=http://gnu.uberglobalmirror.com/rcs/rcs-$MININIX_PKG_VERSION.tar.xz
MININIX_PKG_BUILD_IN_SRC=yes
MININIX_PKG_SHA256=063d5a0d7da1821754b80c639cdae2c82b535c8ff4131f75dc7bbf0cd63a5dff
MININIX_PKG_DEPENDS="diffutils"
MININIX_PKG_EXTRA_CONFIGURE_ARGS="ac_cv_path_DIFF=$MININIX_PREFIX/bin/diff \
ac_cv_path_DIFF3=$MININIX_PREFIX/bin/diff3"

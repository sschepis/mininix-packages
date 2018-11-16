LINUXDROID_PKG_HOMEPAGE=https://www.gnu.org/s/rcs
LINUXDROID_PKG_DESCRIPTION="The GNU Revision Control System
 The Revision Control System (RCS) manages multiple
 revisions of files. RCS automates the storing, retrieval,
 logging, identification, and merging of revisions. RCS is
 useful for text that is revised frequently, for example
 programs, documentation, graphics, papers, and form letters."
LINUXDROID_PKG_VERSION=5.9.4
LINUXDROID_PKG_REVISION=2
LINUXDROID_PKG_SRCURL=http://gnu.uberglobalmirror.com/rcs/rcs-$LINUXDROID_PKG_VERSION.tar.xz
LINUXDROID_PKG_BUILD_IN_SRC=yes
LINUXDROID_PKG_SHA256=063d5a0d7da1821754b80c639cdae2c82b535c8ff4131f75dc7bbf0cd63a5dff
LINUXDROID_PKG_DEPENDS="diffutils"
LINUXDROID_PKG_EXTRA_CONFIGURE_ARGS="ac_cv_path_DIFF=$LINUXDROID_PREFIX/bin/diff \
ac_cv_path_DIFF3=$LINUXDROID_PREFIX/bin/diff3"

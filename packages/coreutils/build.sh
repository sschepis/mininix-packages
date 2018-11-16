LINUXDROID_PKG_HOMEPAGE=https://www.gnu.org/software/coreutils/
LINUXDROID_PKG_DESCRIPTION="Basic file, shell and text manipulation utilities from the GNU project"
LINUXDROID_PKG_VERSION=8.30
LINUXDROID_PKG_REVISION=1
LINUXDROID_PKG_SHA256=e831b3a86091496cdba720411f9748de81507798f6130adeaef872d206e1b057
LINUXDROID_PKG_SRCURL=https://mirrors.kernel.org/gnu/coreutils/coreutils-${LINUXDROID_PKG_VERSION}.tar.xz
# pinky has no usage on Android.
# df does not work either, let system binary prevail.
# $PREFIX/bin/env is provided by busybox for shebangs to work directly.
# users and who doesn't work and does not make much sense for Linuxdroid.
# uptime is provided by procps.
LINUXDROID_PKG_EXTRA_CONFIGURE_ARGS="
gl_cv_host_operating_system=Android
--disable-xattr
--enable-no-install-program=pinky,df,chroot,env,users,who,uptime
--enable-single-binary=symlinks
--without-gmp
"

linuxdroid_step_pre_configure() {
	CPPFLAGS+=" -DDEFAULT_TMPDIR=\\\"$LINUXDROID_PREFIX/tmp\\\""
}

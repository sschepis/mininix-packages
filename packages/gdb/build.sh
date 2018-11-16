LINUXDROID_PKG_HOMEPAGE=https://www.gnu.org/software/gdb/
LINUXDROID_PKG_DESCRIPTION="The standard GNU Debugger that runs on many Unix-like systems and works for many programming languages"
LINUXDROID_PKG_DEPENDS="liblzma, libexpat, readline, ncurses, libmpfr"
LINUXDROID_PKG_VERSION=8.2
LINUXDROID_PKG_SHA256=c3a441a29c7c89720b734e5a9c6289c0a06be7e0c76ef538f7bbcef389347c39
LINUXDROID_PKG_SRCURL=https://mirrors.kernel.org/gnu/gdb/gdb-${LINUXDROID_PKG_VERSION}.tar.xz
# gdb can not build with our normal --disable-static: https://sourceware.org/bugzilla/show_bug.cgi?id=15916
LINUXDROID_PKG_EXTRA_CONFIGURE_ARGS="
--with-system-readline
--with-curses
--enable-static
ac_cv_func_getpwent=no
ac_cv_func_getpwnam=no
"
LINUXDROID_PKG_RM_AFTER_INSTALL="share/gdb/python share/gdb/syscalls share/gdb/system-gdbinit"
LINUXDROID_PKG_MAKE_INSTALL_TARGET="-C gdb install"
LINUXDROID_PKG_BUILD_IN_SRC="yes"

linuxdroid_step_pre_configure() {
	# Fix "undefined reference to 'rpl_gettimeofday'" when building:
	export gl_cv_func_gettimeofday_clobber=no
	export gl_cv_func_gettimeofday_posix_signature=yes
	export gl_cv_func_realpath_works=yes
	export gl_cv_func_lstat_dereferences_slashed_symlink=yes
	export gl_cv_func_memchr_works=yes
	export gl_cv_func_stat_file_slash=yes
	export gl_cv_func_frexp_no_libm=no
	export gl_cv_func_strerror_0_works=yes
	export gl_cv_func_working_strerror=yes
	export gl_cv_func_getcwd_path_max=yes
}

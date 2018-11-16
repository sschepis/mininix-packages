LINUXDROID_PKG_HOMEPAGE=https://cgdb.github.io/
LINUXDROID_PKG_DESCRIPTION="A lightweight curses (terminal-based) interface to the GNU Debugger (GDB)"
LINUXDROID_PKG_DEPENDS="ncurses,readline,gdb,libutil"
LINUXDROID_PKG_VERSION=0.7.0
LINUXDROID_PKG_REVISION=3
LINUXDROID_PKG_SRCURL=https://cgdb.me/files/cgdb-${LINUXDROID_PKG_VERSION}.tar.gz
LINUXDROID_PKG_SHA256=bf7a9264668db3f9342591b08b2cc3bbb08e235ba2372877b4650b70c6fb5423
LINUXDROID_PKG_BUILD_IN_SRC="yes"
LINUXDROID_PKG_EXTRA_CONFIGURE_ARGS="
ac_cv_lib_ncursesw6_addnwstr=yes ac_cv_file__dev_ptmx=yes
ac_cv_func_setpgrp_void=true ac_cv_rl_version=7
ac_cv_file__proc_self_status=yes
"
LINUXDROID_PKG_RM_AFTER_INSTALL="share/applications share/pixmaps"

MININIX_PKG_HOMEPAGE=https://gitlab.com/procps-ng/procps
MININIX_PKG_DESCRIPTION="Utilities that give information about processes using the /proc filesystem"
MININIX_PKG_VERSION=3.3.15
MININIX_PKG_REVISION=2
MININIX_PKG_SHA256=10bd744ffcb3de2d591d2f6acf1a54a7ba070fdcc432a855931a5057149f0465
MININIX_PKG_SRCURL=https://fossies.org/linux/misc/procps-ng-$MININIX_PKG_VERSION.tar.xz
MININIX_PKG_BUILD_IN_SRC=yes
# error.h and stdio_ext.h in unified headers does
# not provide any functionality prior to android-23:
MININIX_PKG_EXTRA_CONFIGURE_ARGS="
ac_cv_search_dlopen=
ac_cv_header_error_h=no
ac_cv_header_stdio_ext_h=no
--enable-sigwinch
--disable-modern-top
"
MININIX_PKG_DEPENDS="ncurses"
# About kill: https://bugs.launchpad.net/ubuntu/+source/coreutils/+bug/141168:
# "For compatibility between distributions, can we have /bin/kill made available from coreutils?"
# About uptime: Does not work on later android versions as /proc/uptime cannot be read.
# About top: The system top works better.
MININIX_PKG_RM_AFTER_INSTALL="
bin/top share/man/man1/top.1
bin/kill share/man/man1/kill.1
bin/slabtop share/man/man1/slabtop.1
bin/uptime share/man/man1/uptime.1
bin/w share/man/man1/w.1
"

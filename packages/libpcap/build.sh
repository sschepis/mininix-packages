MININIX_PKG_HOMEPAGE=https://www.tcpdump.org
MININIX_PKG_DESCRIPTION="Library for network traffic capture"
MININIX_PKG_VERSION=1.9.0
MININIX_PKG_SHA256=b4f87ce52bba24111faf048d3f6450f116b42fe849bc1b997e494f605b3d2735
# The main tcpdump.org was down 2017-04-12, so we're using a mirror:
MININIX_PKG_SRCURL=https://fossies.org/linux/misc/libpcap-${MININIX_PKG_VERSION}.tar.xz
# ac_cv_lib_nl_3_nl_socket_alloc=no to avoid linking against libnl:
MININIX_PKG_EXTRA_CONFIGURE_ARGS="ac_cv_lib_nl_3_nl_socket_alloc=no --with-pcap=linux"
MININIX_PKG_RM_AFTER_INSTALL="bin/pcap-config share/man/man1/pcap-config.1"
MININIX_PKG_BUILD_IN_SRC="yes"

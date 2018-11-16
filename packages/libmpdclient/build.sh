LINUXDROID_PKG_HOMEPAGE=https://www.musicpd.org/libs/libmpdclient/
LINUXDROID_PKG_DESCRIPTION="Asynchronous API library for interfacing MPD in the C, C++ & Objective C languages"
LINUXDROID_PKG_MAINTAINER="Matthew Klein @mklein994"
LINUXDROID_PKG_VERSION=2.16
LINUXDROID_PKG_SHA256=6651898489b69d2f2f8e94f0ed6ddcc0dd2cdbcf99b02131b790551922558d6c
LINUXDROID_PKG_SRCURL=https://github.com/MusicPlayerDaemon/libmpdclient/archive/v${LINUXDROID_PKG_VERSION}.tar.gz
LINUXDROID_PKG_EXTRA_CONFIGURE_ARGS=" -D default_socket==${LINUXDROID_PREFIX}/var/run/mpd/socket"

MININIX_PKG_HOMEPAGE=https://www.musicpd.org/libs/libmpdclient/
MININIX_PKG_DESCRIPTION="Asynchronous API library for interfacing MPD in the C, C++ & Objective C languages"
MININIX_PKG_MAINTAINER="Matthew Klein @mklein994"
MININIX_PKG_VERSION=2.16
MININIX_PKG_SHA256=6651898489b69d2f2f8e94f0ed6ddcc0dd2cdbcf99b02131b790551922558d6c
MININIX_PKG_SRCURL=https://github.com/MusicPlayerDaemon/libmpdclient/archive/v${MININIX_PKG_VERSION}.tar.gz
MININIX_PKG_EXTRA_CONFIGURE_ARGS=" -D default_socket==${MININIX_PREFIX}/var/run/mpd/socket"

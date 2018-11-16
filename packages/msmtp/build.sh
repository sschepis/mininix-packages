LINUXDROID_PKG_HOMEPAGE=https://marlam.de/msmtp/
LINUXDROID_PKG_DESCRIPTION="Lightweight SMTP client"
LINUXDROID_PKG_VERSION=1.8.0
LINUXDROID_PKG_REVISION=1
LINUXDROID_PKG_SHA256=bd730cbf000d1b8382849ea21d569a387e63f936be00dc07c569f67915e53ccd
LINUXDROID_PKG_SRCURL=https://marlam.de/msmtp/releases/msmtp-$LINUXDROID_PKG_VERSION.tar.xz
LINUXDROID_PKG_DEPENDS="libgnutls, libidn"

linuxdroid_step_pre_configure () {
	LDFLAGS=" -llog"
	autoreconf -if
}

MININIX_PKG_HOMEPAGE=https://marlam.de/msmtp/
MININIX_PKG_DESCRIPTION="Lightweight SMTP client"
MININIX_PKG_VERSION=1.8.0
MININIX_PKG_REVISION=1
MININIX_PKG_SHA256=bd730cbf000d1b8382849ea21d569a387e63f936be00dc07c569f67915e53ccd
MININIX_PKG_SRCURL=https://marlam.de/msmtp/releases/msmtp-$MININIX_PKG_VERSION.tar.xz
MININIX_PKG_DEPENDS="libgnutls, libidn"

mininix_step_pre_configure () {
	LDFLAGS=" -llog"
	autoreconf -if
}

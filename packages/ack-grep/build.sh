LINUXDROID_PKG_HOMEPAGE=https://beyondgrep.com/
LINUXDROID_PKG_DESCRIPTION="Tool like grep optimized for programmers"
LINUXDROID_PKG_VERSION=2.24
LINUXDROID_PKG_SHA256=8361e5a2654bc575db27bfa40470c4182d74d51098d390944d98fe7cd5b20d49
LINUXDROID_PKG_SRCURL=https://beyondgrep.com/ack-${LINUXDROID_PKG_VERSION}-single-file
LINUXDROID_PKG_SKIP_SRC_EXTRACT=yes
# Depend on coreutils for bin/env
LINUXDROID_PKG_DEPENDS="perl, coreutils"
LINUXDROID_PKG_PLATFORM_INDEPENDENT=yes

linuxdroid_step_make_install () {
	linuxdroid_download \
		$LINUXDROID_PKG_SRCURL \
		$LINUXDROID_PREFIX/bin/ack \
		$LINUXDROID_PKG_SHA256
	touch $LINUXDROID_PREFIX/bin/ack
	chmod +x $LINUXDROID_PREFIX/bin/ack
}

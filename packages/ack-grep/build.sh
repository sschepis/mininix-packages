MININIX_PKG_HOMEPAGE=https://beyondgrep.com/
MININIX_PKG_DESCRIPTION="Tool like grep optimized for programmers"
MININIX_PKG_VERSION=2.24
MININIX_PKG_SHA256=8361e5a2654bc575db27bfa40470c4182d74d51098d390944d98fe7cd5b20d49
MININIX_PKG_SRCURL=https://beyondgrep.com/ack-${MININIX_PKG_VERSION}-single-file
MININIX_PKG_SKIP_SRC_EXTRACT=yes
# Depend on coreutils for bin/env
MININIX_PKG_DEPENDS="perl, coreutils"
MININIX_PKG_PLATFORM_INDEPENDENT=yes

mininix_step_make_install () {
	mininix_download \
		$MININIX_PKG_SRCURL \
		$MININIX_PREFIX/bin/ack \
		$MININIX_PKG_SHA256
	touch $MININIX_PREFIX/bin/ack
	chmod +x $MININIX_PREFIX/bin/ack
}

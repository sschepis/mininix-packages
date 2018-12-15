MININIX_PKG_HOMEPAGE=https://www.heyu.org/
MININIX_PKG_DESCRIPTION="Program for remotely controlling lights and appliances"
MININIX_PKG_VERSION=2.11-rc3
MININIX_PKG_SHA256=6285f134e03688b5ec03986ef53cce463abc007281996156cac52b61cbeb58b2
MININIX_PKG_SRCURL=https://github.com/HeyuX10Automation/heyu/archive/v$MININIX_PKG_VERSION.tar.gz

mininix_step_pre_configure () {
	# rindex is an obsolete version of strrchr which is not available in Android:
	CFLAGS+=" -Drindex=strrchr"
	LDFLAGS+=" -llog"
}

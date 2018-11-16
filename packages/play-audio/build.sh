LINUXDROID_PKG_HOMEPAGE=https://github.com/linuxdroid/play-audio
LINUXDROID_PKG_DESCRIPTION="Simple commandline audio player for Android"
LINUXDROID_PKG_VERSION=0.5
LINUXDROID_PKG_REVISION=1
LINUXDROID_PKG_SHA256=e114123c4b337cddb1d4aa6c3287574d8c81b2dc4b3abc07ce21616fa14f9e82
LINUXDROID_PKG_SRCURL=https://github.com/linuxdroid/play-audio/archive/v${LINUXDROID_PKG_VERSION}.tar.gz
LINUXDROID_PKG_BUILD_IN_SRC=yes

linuxdroid_step_post_make_install () {
	local LIBEXEC_BINARY=$LINUXDROID_PREFIX/libexec/play-audio
	local BIN_BINARY=$LINUXDROID_PREFIX/bin/play-audio
	mv $BIN_BINARY $LIBEXEC_BINARY

	cat << EOF > $BIN_BINARY
#!/bin/sh

# Avoid linker errors due to libOpenSLES.so:
LD_PRELOAD=$LINUXDROID_PREFIX/lib/libc++_shared.so LD_LIBRARY_PATH= exec $LIBEXEC_BINARY "\$@"
EOF

	chmod +x $BIN_BINARY
}

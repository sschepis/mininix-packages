MININIX_PKG_HOMEPAGE=https://github.com/mininix/play-audio
MININIX_PKG_DESCRIPTION="Simple commandline audio player for Android"
MININIX_PKG_VERSION=0.5
MININIX_PKG_REVISION=1
MININIX_PKG_SHA256=e114123c4b337cddb1d4aa6c3287574d8c81b2dc4b3abc07ce21616fa14f9e82
MININIX_PKG_SRCURL=https://github.com/mininix/play-audio/archive/v${MININIX_PKG_VERSION}.tar.gz
MININIX_PKG_BUILD_IN_SRC=yes

mininix_step_post_make_install () {
	local LIBEXEC_BINARY=$MININIX_PREFIX/libexec/play-audio
	local BIN_BINARY=$MININIX_PREFIX/bin/play-audio
	mv $BIN_BINARY $LIBEXEC_BINARY

	cat << EOF > $BIN_BINARY
#!/bin/sh

# Avoid linker errors due to libOpenSLES.so:
LD_PRELOAD=$MININIX_PREFIX/lib/libc++_shared.so LD_LIBRARY_PATH= exec $LIBEXEC_BINARY "\$@"
EOF

	chmod +x $BIN_BINARY
}

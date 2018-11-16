LINUXDROID_PKG_HOMEPAGE=https://github.com/fornwall/apksigner
LINUXDROID_PKG_DESCRIPTION="APK signing tool"
LINUXDROID_PKG_VERSION=0.7
LINUXDROID_PKG_REVISION=1
LINUXDROID_PKG_SHA256=340560c4f75af3501f037452bcf184fa48fd18bc877a4cce9a51a3fa047b4b38
LINUXDROID_PKG_SRCURL=https://github.com/fornwall/apksigner/archive/v${LINUXDROID_PKG_VERSION}.tar.gz
LINUXDROID_PKG_BUILD_IN_SRC=yes
LINUXDROID_PKG_PLATFORM_INDEPENDENT=true

linuxdroid_step_make () {
	mkdir -p $LINUXDROID_PREFIX/share/{dex,man/man1}

	cp apksigner.1 $LINUXDROID_PREFIX/share/man/man1/

	GRADLE_OPTS=" -Dorg.gradle.daemon=false" ./gradlew
	$LINUXDROID_D8 \
		--classpath $ANDROID_HOME/platforms/android-$LINUXDROID_PKG_API_LEVEL/android.jar \
		--release \
		--min-api $LINUXDROID_PKG_API_LEVEL \
		--output $LINUXDROID_PKG_TMPDIR \
		./build/libs/src-all.jar

	cd $LINUXDROID_PKG_TMPDIR
	jar cf apksigner.jar classes.dex
	mv apksigner.jar $LINUXDROID_PREFIX/share/dex/apksigner.jar

	echo '#!/bin/sh' > $LINUXDROID_PREFIX/bin/apksigner
	echo "dalvikvm -cp $LINUXDROID_PREFIX/share/dex/apksigner.jar net.fornwall.apksigner.Main \$@" >> $LINUXDROID_PREFIX/bin/apksigner
	chmod +x $LINUXDROID_PREFIX/bin/apksigner
}

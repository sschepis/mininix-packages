MININIX_PKG_HOMEPAGE=https://github.com/fornwall/apksigner
MININIX_PKG_DESCRIPTION="APK signing tool"
MININIX_PKG_VERSION=0.7
MININIX_PKG_REVISION=1
MININIX_PKG_SHA256=340560c4f75af3501f037452bcf184fa48fd18bc877a4cce9a51a3fa047b4b38
MININIX_PKG_SRCURL=https://github.com/fornwall/apksigner/archive/v${MININIX_PKG_VERSION}.tar.gz
MININIX_PKG_BUILD_IN_SRC=yes
MININIX_PKG_PLATFORM_INDEPENDENT=true

mininix_step_make () {
	mkdir -p $MININIX_PREFIX/share/{dex,man/man1}

	cp apksigner.1 $MININIX_PREFIX/share/man/man1/

	GRADLE_OPTS=" -Dorg.gradle.daemon=false" ./gradlew
	$MININIX_D8 \
		--classpath $ANDROID_HOME/platforms/android-$MININIX_PKG_API_LEVEL/android.jar \
		--release \
		--min-api $MININIX_PKG_API_LEVEL \
		--output $MININIX_PKG_TMPDIR \
		./build/libs/src-all.jar

	cd $MININIX_PKG_TMPDIR
	jar cf apksigner.jar classes.dex
	mv apksigner.jar $MININIX_PREFIX/share/dex/apksigner.jar

	echo '#!/bin/sh' > $MININIX_PREFIX/bin/apksigner
	echo "dalvikvm -cp $MININIX_PREFIX/share/dex/apksigner.jar net.fornwall.apksigner.Main \$@" >> $MININIX_PREFIX/bin/apksigner
	chmod +x $MININIX_PREFIX/bin/apksigner
}

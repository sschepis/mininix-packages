MININIX_PKG_HOMEPAGE=https://github.com/michalbednarski/MininixAm
MININIX_PKG_DESCRIPTION="Android Oreo-compatible am command reimplementation"
MININIX_PKG_MAINTAINER="Michal Bednarski @michalbednarski"
MININIX_PKG_VERSION=0.2
MININIX_PKG_SHA256=bde5ca8a6778a8be99370b35453eca92c8283c2987016a3d8ea6eddbad0c3f0e
MININIX_PKG_SRCURL=https://github.com/michalbednarski/MininixAm/archive/v$MININIX_PKG_VERSION.zip
MININIX_PKG_PLATFORM_INDEPENDENT=yes
MININIX_PKG_BUILD_IN_SRC=yes
MININIX_PKG_CONFLICTS="mininix-tools (<< 0.51)"

mininix_step_make () {
	export ANDROID_HOME
	GRADLE_OPTS=" -Dorg.gradle.daemon=false" ./gradlew :app:assembleRelease
}

mininix_step_make_install () {
	cp $MININIX_PKG_SRCDIR/am-libexec-packaged $MININIX_PREFIX/bin/am
	mkdir -p $MININIX_PREFIX/libexec/mininix-am
	cp $MININIX_PKG_SRCDIR/app/build/outputs/apk/release/app-release-unsigned.apk $MININIX_PREFIX/libexec/mininix-am/am.apk
}

LINUXDROID_PKG_HOMEPAGE=https://github.com/michalbednarski/LinuxdroidAm
LINUXDROID_PKG_DESCRIPTION="Android Oreo-compatible am command reimplementation"
LINUXDROID_PKG_MAINTAINER="Michal Bednarski @michalbednarski"
LINUXDROID_PKG_VERSION=0.2
LINUXDROID_PKG_SHA256=bde5ca8a6778a8be99370b35453eca92c8283c2987016a3d8ea6eddbad0c3f0e
LINUXDROID_PKG_SRCURL=https://github.com/michalbednarski/LinuxdroidAm/archive/v$LINUXDROID_PKG_VERSION.zip
LINUXDROID_PKG_PLATFORM_INDEPENDENT=yes
LINUXDROID_PKG_BUILD_IN_SRC=yes
LINUXDROID_PKG_CONFLICTS="linuxdroid-tools (<< 0.51)"

linuxdroid_step_make () {
	export ANDROID_HOME
	GRADLE_OPTS=" -Dorg.gradle.daemon=false" ./gradlew :app:assembleRelease
}

linuxdroid_step_make_install () {
	cp $LINUXDROID_PKG_SRCDIR/am-libexec-packaged $LINUXDROID_PREFIX/bin/am
	mkdir -p $LINUXDROID_PREFIX/libexec/linuxdroid-am
	cp $LINUXDROID_PKG_SRCDIR/app/build/outputs/apk/release/app-release-unsigned.apk $LINUXDROID_PREFIX/libexec/linuxdroid-am/am.apk
}

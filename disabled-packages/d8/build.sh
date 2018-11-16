LINUXDROID_PKG_HOMEPAGE=https://r8.googlesource.com/r8
LINUXDROID_PKG_DESCRIPTION="Dexer that converts java byte code to dex code"
LINUXDROID_PKG_VERSION=$LINUXDROID_ANDROID_BUILD_TOOLS_VERSION
LINUXDROID_PKG_PLATFORM_INDEPENDENT=true

linuxdroid_step_make_install () {
	# Rewrite packages to avoid using com.android.* classes which may clash with
	# classes in the Android runtime on devices (see #1801):
	local JARJAR=$LINUXDROID_PKG_CACHEDIR/jarjar.jar
	local RULEFILE=$LINUXDROID_PKG_TMPDIR/jarjar-rule.txt
	local REWRITTEN_DX=$LINUXDROID_PKG_TMPDIR/d8-rewritten.jar
	linuxdroid_download \
		http://repo.bodar.com/com/googlecode/jarjar/jarjar/1.4.1/jarjar-1.4.1.jar \
		$JARJAR \
		c16b1cee296526baae432c382f83d540d4b648dc21923428a66a69ba43b7df9e
	echo 'rule com.android.** d8.@1' > $RULEFILE
	java -jar $JARJAR process $RULEFILE \
		$ANDROID_HOME/build-tools/${LINUXDROID_PKG_VERSION}/lib/d8.jar \
		$REWRITTEN_DX

	# Dex the rewritten jar file:
	mkdir -p $LINUXDROID_PREFIX/share/dex
	$LINUXDROID_D8 \
		--classpath $ANDROID_HOME/platforms/android-$LINUXDROID_PKG_API_LEVEL/android.jar \
		--release \
		--min-api 21 \
		--output $LINUXDROID_PREFIX/share/dex/d8.jar \
		$REWRITTEN_DX

	install $LINUXDROID_PKG_BUILDER_DIR/d8 $LINUXDROID_PREFIX/bin/d8
	perl -p -i -e "s%\@LINUXDROID_PREFIX\@%${LINUXDROID_PREFIX}%g" $LINUXDROID_PREFIX/bin/d8
}

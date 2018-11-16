LINUXDROID_PKG_HOMEPAGE=http://developer.android.com/tools/help/index.html
LINUXDROID_PKG_DESCRIPTION="Command which takes in class files and reformulates them for usage on Android"
LINUXDROID_PKG_VERSION=$LINUXDROID_ANDROID_BUILD_TOOLS_VERSION
LINUXDROID_PKG_PLATFORM_INDEPENDENT=true

linuxdroid_step_make_install () {
	# Rewrite packages to avoid using com.android.* classes which may clash with
	# classes in the Android runtime on devices (see #1801):
	local JARJAR=$LINUXDROID_PKG_CACHEDIR/jarjar.jar
	local RULEFILE=$LINUXDROID_PKG_TMPDIR/jarjar-rule.txt
	local REWRITTEN_DX=$LINUXDROID_PKG_TMPDIR/dx-rewritten.jar
	linuxdroid_download \
		http://central.maven.org/maven2/com/googlecode/jarjar/jarjar/1.3/jarjar-1.3.jar \
		$JARJAR \
		4225c8ee1bf3079c4b07c76fe03c3e28809a22204db6249c9417efa4f804b3a7
	echo 'rule com.android.** dx.@1' > $RULEFILE
	java -jar $JARJAR process $RULEFILE \
		$ANDROID_HOME/build-tools/${LINUXDROID_PKG_VERSION}/lib/dx.jar \
		$REWRITTEN_DX

	# Dex the rewritten jar file:
	mkdir -p $LINUXDROID_PREFIX/share/dex
	$LINUXDROID_D8 \
		--release \
		--min-api 21 \
		--output $LINUXDROID_PKG_TMPDIR \
		$REWRITTEN_DX

	cd $LINUXDROID_PKG_TMPDIR
	jar cf dx.jar classes.dex
	mv dx.jar $LINUXDROID_PREFIX/share/dex/dx.jar

	install $LINUXDROID_PKG_BUILDER_DIR/dx $LINUXDROID_PREFIX/bin/dx
	perl -p -i -e "s%\@LINUXDROID_PREFIX\@%${LINUXDROID_PREFIX}%g" $LINUXDROID_PREFIX/bin/dx
}

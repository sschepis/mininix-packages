MININIX_PKG_HOMEPAGE=http://developer.android.com/tools/help/index.html
MININIX_PKG_DESCRIPTION="Command which takes in class files and reformulates them for usage on Android"
MININIX_PKG_VERSION=$MININIX_ANDROID_BUILD_TOOLS_VERSION
MININIX_PKG_PLATFORM_INDEPENDENT=true

mininix_step_make_install () {
	# Rewrite packages to avoid using com.android.* classes which may clash with
	# classes in the Android runtime on devices (see #1801):
	local JARJAR=$MININIX_PKG_CACHEDIR/jarjar.jar
	local RULEFILE=$MININIX_PKG_TMPDIR/jarjar-rule.txt
	local REWRITTEN_DX=$MININIX_PKG_TMPDIR/dx-rewritten.jar
	mininix_download \
		http://central.maven.org/maven2/com/googlecode/jarjar/jarjar/1.3/jarjar-1.3.jar \
		$JARJAR \
		4225c8ee1bf3079c4b07c76fe03c3e28809a22204db6249c9417efa4f804b3a7
	echo 'rule com.android.** dx.@1' > $RULEFILE
	java -jar $JARJAR process $RULEFILE \
		$ANDROID_HOME/build-tools/${MININIX_PKG_VERSION}/lib/dx.jar \
		$REWRITTEN_DX

	# Dex the rewritten jar file:
	mkdir -p $MININIX_PREFIX/share/dex
	$MININIX_D8 \
		--release \
		--min-api 21 \
		--output $MININIX_PKG_TMPDIR \
		$REWRITTEN_DX

	cd $MININIX_PKG_TMPDIR
	jar cf dx.jar classes.dex
	mv dx.jar $MININIX_PREFIX/share/dex/dx.jar

	install $MININIX_PKG_BUILDER_DIR/dx $MININIX_PREFIX/bin/dx
	perl -p -i -e "s%\@MININIX_PREFIX\@%${MININIX_PREFIX}%g" $MININIX_PREFIX/bin/dx
}

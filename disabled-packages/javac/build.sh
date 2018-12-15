MININIX_PKG_HOMEPAGE=http://docs.oracle.com/javase/8/docs/technotes/tools/windows/javac.html
MININIX_PKG_DESCRIPTION="Java programming language compiler from (openjdk)"
MININIX_PKG_VERSION=8u45
MININIX_PKG_PLATFORM_INDEPENDENT=true

mininix_step_extract_package () {
	mkdir $MININIX_PKG_SRCDIR
}

mininix_step_make () {
	RAW_JAR=/usr/lib/jvm/java-7-openjdk-amd64/lib/tools.jar

        mkdir -p $MININIX_PREFIX/share/dex
	$MININIX_DX \
		--dex \
		--output=$MININIX_PREFIX/share/dex/tools.jar \
		$RAW_JAR

	install $MININIX_PKG_BUILDER_DIR/javac $MININIX_PREFIX/bin/javac
	perl -p -i -e "s%\@MININIX_PREFIX\@%${MININIX_PREFIX}%g" $MININIX_PREFIX/bin/javac
}

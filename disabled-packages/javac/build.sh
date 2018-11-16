LINUXDROID_PKG_HOMEPAGE=http://docs.oracle.com/javase/8/docs/technotes/tools/windows/javac.html
LINUXDROID_PKG_DESCRIPTION="Java programming language compiler from (openjdk)"
LINUXDROID_PKG_VERSION=8u45
LINUXDROID_PKG_PLATFORM_INDEPENDENT=true

linuxdroid_step_extract_package () {
	mkdir $LINUXDROID_PKG_SRCDIR
}

linuxdroid_step_make () {
	RAW_JAR=/usr/lib/jvm/java-7-openjdk-amd64/lib/tools.jar

        mkdir -p $LINUXDROID_PREFIX/share/dex
	$LINUXDROID_DX \
		--dex \
		--output=$LINUXDROID_PREFIX/share/dex/tools.jar \
		$RAW_JAR

	install $LINUXDROID_PKG_BUILDER_DIR/javac $LINUXDROID_PREFIX/bin/javac
	perl -p -i -e "s%\@LINUXDROID_PREFIX\@%${LINUXDROID_PREFIX}%g" $LINUXDROID_PREFIX/bin/javac
}

LINUXDROID_PKG_HOMEPAGE=http://www.eclipse.org/jdt/core/
LINUXDROID_PKG_DESCRIPTION="Eclipse Compiler for Java, for android 5 and 6"
LINUXDROID_PKG_VERSION=4.6.2
local _date=201611241400
LINUXDROID_PKG_SHA256=9953dc2be829732e1b939106a71de018f660891220dbca559a5c7bff84883e51
LINUXDROID_PKG_SRCURL=http://archive.eclipse.org/eclipse/downloads/drops${LINUXDROID_PKG_VERSION:0:1}/R-$LINUXDROID_PKG_VERSION-$_date/ecj-$LINUXDROID_PKG_VERSION.jar
LINUXDROID_PKG_PLATFORM_INDEPENDENT=true
LINUXDROID_PKG_CONFLICTS="ecj"

linuxdroid_step_extract_package () {
	mkdir $LINUXDROID_PKG_SRCDIR
}

linuxdroid_step_make () {
	local RAW_JAR=$LINUXDROID_PKG_CACHEDIR/ecj-${LINUXDROID_PKG_VERSION}.jar
	linuxdroid_download $LINUXDROID_PKG_SRCURL \
		$RAW_JAR \
		$LINUXDROID_PKG_SHA256

	mkdir -p $LINUXDROID_PREFIX/share/{dex,java}
	$LINUXDROID_D8 \
		--classpath $ANDROID_HOME/platforms/android-$LINUXDROID_PKG_API_LEVEL/android.jar \
		--release \
		--min-api 21 \
		--output $LINUXDROID_PKG_TMPDIR \
		$RAW_JAR

	# Package classes.dex into jar:
	cd $LINUXDROID_PKG_TMPDIR
	jar cf ecj.jar classes.dex
	# Add needed properties file to jar file:
	jar xf $RAW_JAR org/eclipse/jdt/internal/compiler/batch/messages.properties
	jar uf ecj.jar  org/eclipse/jdt/internal/compiler/batch/messages.properties
	jar xf $RAW_JAR org/eclipse/jdt/internal/compiler/problem/messages.properties
	jar uf ecj.jar  org/eclipse/jdt/internal/compiler/problem/messages.properties
	jar xf $RAW_JAR org/eclipse/jdt/internal/compiler/messages.properties
	jar uf ecj.jar  org/eclipse/jdt/internal/compiler/messages.properties
	jar xf $RAW_JAR org/eclipse/jdt/internal/compiler/parser/readableNames.props
	jar uf ecj.jar  org/eclipse/jdt/internal/compiler/parser/readableNames.props
	for i in `seq 1 24`; do
		jar xf $RAW_JAR org/eclipse/jdt/internal/compiler/parser/parser$i.rsc
		jar uf ecj.jar  org/eclipse/jdt/internal/compiler/parser/parser$i.rsc
	done
	# Move into place:
	mv ecj.jar $LINUXDROID_PREFIX/share/dex/ecj.jar

	rm -rf android-jar
	mkdir android-jar
	cd android-jar

        # We need the android classes for JDT to compile against.
	cp $ANDROID_HOME/platforms/android-27/android.jar .
	unzip -q android.jar
	rm -Rf android.jar resources.arsc res assets
	jar cfM android.jar .

	cp $LINUXDROID_PKG_TMPDIR/android-jar/android.jar $LINUXDROID_PREFIX/share/java/android.jar

	# Bundle in an android.jar from an older API also, for those who want to
	# build apps that run on older Android versions.
	rm -Rf ./*
	cp $ANDROID_HOME/platforms/android-21/android.jar android.jar
	unzip -q android.jar
	rm -Rf android.jar resources.arsc res assets
	jar cfM android-21.jar .
	cp $LINUXDROID_PKG_TMPDIR/android-jar/android-21.jar $LINUXDROID_PREFIX/share/java/

	rm -Rf $LINUXDROID_PREFIX/bin/javac
	install $LINUXDROID_PKG_BUILDER_DIR/ecj $LINUXDROID_PREFIX/bin/ecj
	perl -p -i -e "s%\@LINUXDROID_PREFIX\@%${LINUXDROID_PREFIX}%g" $LINUXDROID_PREFIX/bin/ecj
	install $LINUXDROID_PKG_BUILDER_DIR/ecj-21 $LINUXDROID_PREFIX/bin/ecj-21
	perl -p -i -e "s%\@LINUXDROID_PREFIX\@%${LINUXDROID_PREFIX}%g" $LINUXDROID_PREFIX/bin/ecj-21
}

MININIX_PKG_HOMEPAGE=http://www.eclipse.org/jdt/core/
MININIX_PKG_DESCRIPTION="Eclipse Compiler for Java, for android 5 and 6"
MININIX_PKG_VERSION=4.6.2
local _date=201611241400
MININIX_PKG_SHA256=9953dc2be829732e1b939106a71de018f660891220dbca559a5c7bff84883e51
MININIX_PKG_SRCURL=http://archive.eclipse.org/eclipse/downloads/drops${MININIX_PKG_VERSION:0:1}/R-$MININIX_PKG_VERSION-$_date/ecj-$MININIX_PKG_VERSION.jar
MININIX_PKG_PLATFORM_INDEPENDENT=true
MININIX_PKG_CONFLICTS="ecj"

mininix_step_extract_package () {
	mkdir $MININIX_PKG_SRCDIR
}

mininix_step_make () {
	local RAW_JAR=$MININIX_PKG_CACHEDIR/ecj-${MININIX_PKG_VERSION}.jar
	mininix_download $MININIX_PKG_SRCURL \
		$RAW_JAR \
		$MININIX_PKG_SHA256

	mkdir -p $MININIX_PREFIX/share/{dex,java}
	$MININIX_D8 \
		--classpath $ANDROID_HOME/platforms/android-$MININIX_PKG_API_LEVEL/android.jar \
		--release \
		--min-api 21 \
		--output $MININIX_PKG_TMPDIR \
		$RAW_JAR

	# Package classes.dex into jar:
	cd $MININIX_PKG_TMPDIR
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
	mv ecj.jar $MININIX_PREFIX/share/dex/ecj.jar

	rm -rf android-jar
	mkdir android-jar
	cd android-jar

        # We need the android classes for JDT to compile against.
	cp $ANDROID_HOME/platforms/android-27/android.jar .
	unzip -q android.jar
	rm -Rf android.jar resources.arsc res assets
	jar cfM android.jar .

	cp $MININIX_PKG_TMPDIR/android-jar/android.jar $MININIX_PREFIX/share/java/android.jar

	# Bundle in an android.jar from an older API also, for those who want to
	# build apps that run on older Android versions.
	rm -Rf ./*
	cp $ANDROID_HOME/platforms/android-21/android.jar android.jar
	unzip -q android.jar
	rm -Rf android.jar resources.arsc res assets
	jar cfM android-21.jar .
	cp $MININIX_PKG_TMPDIR/android-jar/android-21.jar $MININIX_PREFIX/share/java/

	rm -Rf $MININIX_PREFIX/bin/javac
	install $MININIX_PKG_BUILDER_DIR/ecj $MININIX_PREFIX/bin/ecj
	perl -p -i -e "s%\@MININIX_PREFIX\@%${MININIX_PREFIX}%g" $MININIX_PREFIX/bin/ecj
	install $MININIX_PKG_BUILDER_DIR/ecj-21 $MININIX_PREFIX/bin/ecj-21
	perl -p -i -e "s%\@MININIX_PREFIX\@%${MININIX_PREFIX}%g" $MININIX_PREFIX/bin/ecj-21
}

LINUXDROID_PKG_HOMEPAGE=http://ant.apache.org/
LINUXDROID_PKG_DESCRIPTION="Java based build tool like make"
LINUXDROID_PKG_VERSION=1.9.6
LINUXDROID_PKG_SRCURL=http://apache.mirrors.spacedump.net//ant/binaries/apache-ant-${LINUXDROID_PKG_VERSION}-bin.tar.bz2
LINUXDROID_PKG_BUILD_IN_SRC=yes
LINUXDROID_PKG_PLATFORM_INDEPENDENT=true

linuxdroid_step_make_install () {
        mkdir -p $LINUXDROID_PREFIX/share/ant/lib

        for jar in ant ant-launcher; do
                $LINUXDROID_DX \
                        --dex \
                        --output=$LINUXDROID_PREFIX/share/ant/lib/${jar}.jar \
                        lib/${jar}.jar
        done

	install $LINUXDROID_PKG_BUILDER_DIR/ant $LINUXDROID_PREFIX/bin/ant
	perl -p -i -e "s%\@LINUXDROID_PREFIX\@%${LINUXDROID_PREFIX}%g" $LINUXDROID_PREFIX/bin/ant
}

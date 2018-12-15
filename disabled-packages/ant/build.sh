MININIX_PKG_HOMEPAGE=http://ant.apache.org/
MININIX_PKG_DESCRIPTION="Java based build tool like make"
MININIX_PKG_VERSION=1.9.6
MININIX_PKG_SRCURL=http://apache.mirrors.spacedump.net//ant/binaries/apache-ant-${MININIX_PKG_VERSION}-bin.tar.bz2
MININIX_PKG_BUILD_IN_SRC=yes
MININIX_PKG_PLATFORM_INDEPENDENT=true

mininix_step_make_install () {
        mkdir -p $MININIX_PREFIX/share/ant/lib

        for jar in ant ant-launcher; do
                $MININIX_DX \
                        --dex \
                        --output=$MININIX_PREFIX/share/ant/lib/${jar}.jar \
                        lib/${jar}.jar
        done

	install $MININIX_PKG_BUILDER_DIR/ant $MININIX_PREFIX/bin/ant
	perl -p -i -e "s%\@MININIX_PREFIX\@%${MININIX_PREFIX}%g" $MININIX_PREFIX/bin/ant
}

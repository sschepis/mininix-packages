LINUXDROID_PKG_HOMEPAGE=https://github.com/google/leveldb
LINUXDROID_PKG_DESCRIPTION="Fast key-value storage library"
LINUXDROID_PKG_VERSION=1.20
LINUXDROID_PKG_REVISION=1
LINUXDROID_PKG_SHA256=f5abe8b5b209c2f36560b75f32ce61412f39a2922f7045ae764a2c23335b6664
LINUXDROID_PKG_SRCURL=https://github.com/google/leveldb/archive/v${LINUXDROID_PKG_VERSION}.tar.gz
LINUXDROID_PKG_BUILD_IN_SRC=yes

linuxdroid_step_make_install() {
	rm -Rf $LINUXDROID_PREFIX/include/leveldb/
	cp -Rf include/leveldb/ $LINUXDROID_PREFIX/include/
	cp out-shared/libleveldb.so.$LINUXDROID_PKG_VERSION $LINUXDROID_PREFIX/lib/
	( cd $LINUXDROID_PREFIX/lib/ && \
	  ln -s -f libleveldb.so.$LINUXDROID_PKG_VERSION libleveldb.so && \
	  ln -s -f libleveldb.so.$LINUXDROID_PKG_VERSION libleveldb.so.1 )
}

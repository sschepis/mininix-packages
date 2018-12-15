MININIX_PKG_HOMEPAGE=https://github.com/google/leveldb
MININIX_PKG_DESCRIPTION="Fast key-value storage library"
MININIX_PKG_VERSION=1.20
MININIX_PKG_REVISION=1
MININIX_PKG_SHA256=f5abe8b5b209c2f36560b75f32ce61412f39a2922f7045ae764a2c23335b6664
MININIX_PKG_SRCURL=https://github.com/google/leveldb/archive/v${MININIX_PKG_VERSION}.tar.gz
MININIX_PKG_BUILD_IN_SRC=yes

mininix_step_make_install() {
	rm -Rf $MININIX_PREFIX/include/leveldb/
	cp -Rf include/leveldb/ $MININIX_PREFIX/include/
	cp out-shared/libleveldb.so.$MININIX_PKG_VERSION $MININIX_PREFIX/lib/
	( cd $MININIX_PREFIX/lib/ && \
	  ln -s -f libleveldb.so.$MININIX_PKG_VERSION libleveldb.so && \
	  ln -s -f libleveldb.so.$MININIX_PKG_VERSION libleveldb.so.1 )
}

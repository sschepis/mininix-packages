MININIX_PKG_HOMEPAGE=http://www.hboehm.info/gc/
MININIX_PKG_DESCRIPTION="Library providing the Boehm-Demers-Weiser conservative garbage collector"
MININIX_PKG_VERSION=(7.6.8
                    7.6.6)
MININIX_PKG_SHA256=(040ac5cdbf1bebc7c8cd4928996bbae0c54497c151ea5639838fa0128102e258
                   99feabc5f54877f314db4fadeb109f0b3e1d1a54afb6b4b3dfba1e707e38e074)
MININIX_PKG_SRCURL=(https://github.com/ivmai/bdwgc/releases/download/v$MININIX_PKG_VERSION/gc-$MININIX_PKG_VERSION.tar.gz
		   https://github.com/ivmai/libatomic_ops/releases/download/v${MININIX_PKG_VERSION[1]}/libatomic_ops-${MININIX_PKG_VERSION[1]}.tar.gz)
MININIX_PKG_RM_AFTER_INSTALL="share/gc"

mininix_step_post_extract_package () {
	mv libatomic_ops-${MININIX_PKG_VERSION[1]} libatomic_ops
	./autogen.sh
}

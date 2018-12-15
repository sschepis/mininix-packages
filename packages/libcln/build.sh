MININIX_PKG_HOMEPAGE=https://www.ginac.de/CLN/
MININIX_PKG_DESCRIPTION="CLN is a library for efficient computations with all kinds of numbers in arbitrary precision"
MININIX_PKG_VERSION=1.3.4
MININIX_PKG_REVISION=3
MININIX_PKG_SRCURL=https://fossies.org/linux/privat/cln-$MININIX_PKG_VERSION.tar.xz
MININIX_PKG_SHA256=c32e59b6afbcf8b84075ab454c42982429c6ea9675aee2bbda176cb85293e38f
MININIX_PKG_DEPENDS="libgmp"
MININIX_PKG_BUILD_IN_SRC=yes

mininix_step_pre_configure() {
	if [ $MININIX_ARCH = arm ]; then
		# See the following section in INSTALL:
		# "(*) On these platforms, problems with the assembler routines have been
		# reported. It may be best to add "-DNO_ASM" to CPPFLAGS before configuring."
		CPPFLAGS+=" -DNO_ASM"
		CXXFLAGS+=" -fintegrated-as"
	fi

	sed -i -e 's%tests/Makefile %%' configure.ac
	sed -i -e 's%examples/Makefile %%' configure.ac
	sed -i -e 's%benchmarks/Makefile %%' configure.ac

	autoreconf
}

mininix_step_post_configure() {
	cd $MININIX_PKG_SRCDIR
	sed -i -e 's% tests%%' Makefile
	sed -i -e 's% examples%%' Makefile
	sed -i -e 's% benchmarks%%' Makefile
}

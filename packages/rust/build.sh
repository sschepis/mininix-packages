LINUXDROID_PKG_HOMEPAGE=https://www.rust-lang.org/
LINUXDROID_PKG_DESCRIPTION="Systems programming language focused on safety, speed and concurrency"
LINUXDROID_PKG_MAINTAINER="Kevin Cotugno @kcotugno"
LINUXDROID_PKG_VERSION=1.30.1
LINUXDROID_PKG_SRCURL=https://static.rust-lang.org/dist/rustc-$LINUXDROID_PKG_VERSION-src.tar.gz
LINUXDROID_PKG_SHA256=36a38902dbd9a3e1240d46ab0f2ca40d2fd07c2ab6508ed7970c6c4c036b5b29
LINUXDROID_PKG_DEPENDS="clang, openssl"

linuxdroid_step_configure () {
	linuxdroid_setup_cmake

	local triple=`printf $LINUXDROID_HOST_PLATFORM | sed s/arm/armv7/`

	sed "s%\\@LINUXDROID_PREFIX\\@%$LINUXDROID_PREFIX%g" \
		$LINUXDROID_PKG_BUILDER_DIR/config.toml \
		| sed "s%\\@LINUXDROID_STANDALONE_TOOLCHAIN\\@%$LINUXDROID_STANDALONE_TOOLCHAIN%g" \
		| sed "s%\\@triple\\@%$triple%g" \
		> config.toml

	local env_host=`printf $triple | tr a-z A-Z | sed s/-/_/g`

	export LD_LIBRARY_PATH=$LINUXDROID_PKG_BUILDDIR/build/x86_64-unknown-linux-gnu/llvm/lib
	export ${env_host}_OPENSSL_DIR=$LINUXDROID_PREFIX
	export X86_64_UNKNOWN_LINUX_GNU_OPENSSL_LIB_DIR=/usr/lib/x86_64-linux-gnu
	export X86_64_UNKNOWN_LINUX_GNU_OPENSSL_INCLUDE_DIR=/usr/include

	unset CC CXX CPP LD CFLAGS CXXFLAGS CPPFLAGS LDFLAGS
}

linuxdroid_step_make () {
	$LINUXDROID_PKG_SRCDIR/x.py dist

}

linuxdroid_step_make_install () {
	local host_files_to_remove="$LINUXDROID_PREFIX/lib/rustlib/x86_64-unknown-linux-gnu \
		$LINUXDROID_PREFIX/lib/rustlib/manifest-rust-analysis-x86_64-unknown-linux-gnu \
		$LINUXDROID_PREFIX/lib/rustlib/manifest-rust-std-x86_64-unknown-linux-gnu"

	$LINUXDROID_PKG_SRCDIR/x.py install && rm -rf $host_files_to_remove
}

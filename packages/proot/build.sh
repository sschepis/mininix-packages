MININIX_PKG_HOMEPAGE=https://proot-me.github.io/
MININIX_PKG_DESCRIPTION="Emulate chroot, bind mount and binfmt_misc for non-root users"
# Just bump commit and version when needed:
_COMMIT=df715ceac26cf331a626b7ccabcb94c4fd7d12cf
MININIX_PKG_VERSION=5.1.107
MININIX_PKG_REVISION=18
MININIX_PKG_SRCURL=https://github.com/mininix/proot/archive/${_COMMIT}.zip
MININIX_PKG_SHA256=026d3f522d4d55310c433e00839be5410a46b9e5626a54bdb1b1c9869dd1d032
MININIX_PKG_DEPENDS="libtalloc"

# Install loader in libexec instead of extracting it every time
export PROOT_UNBUNDLE_LOADER=$MININIX_PREFIX/libexec/proot

mininix_step_pre_configure() {
	export LD=$CC
	CPPFLAGS+=" -DARG_MAX=131072"
}

mininix_step_make_install () {
	export CROSS_COMPILE=${MININIX_HOST_PLATFORM}-

	cd $MININIX_PKG_SRCDIR/src
	make V=1
	make install

	mkdir -p $MININIX_PREFIX/share/man/man1
	cp $MININIX_PKG_SRCDIR/doc/proot/man.1 $MININIX_PREFIX/share/man/man1/proot.1

	cp $MININIX_PKG_BUILDER_DIR/mininix-chroot $MININIX_PREFIX/bin/
}

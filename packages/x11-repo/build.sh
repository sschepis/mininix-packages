MININIX_PKG_HOMEPAGE=https://mininix-x11.ml
MININIX_PKG_DESCRIPTION="Package repository containing X11 programs and libraries"
MININIX_PKG_MAINTAINER="Leonid Plyushch <leonid.plyushch@gmail.com> @xeffyr"
MININIX_PKG_VERSION=1.2
MININIX_PKG_PLATFORM_INDEPENDENT=yes

mininix_step_make_install() {
	mkdir -p $MININIX_PREFIX/etc/apt/{sources.list.d,trusted.gpg.d}
	echo "deb https://mininix-x11.ml x11 main" > $MININIX_PREFIX/etc/apt/sources.list.d/x11.list
	cp $MININIX_PKG_BUILDER_DIR/xeffyr.gpg $MININIX_PREFIX/etc/apt/trusted.gpg.d/
}

mininix_step_create_debscripts () {
	echo "#!$MININIX_PREFIX/bin/sh" > postinst
	echo "echo Downloading updated package list ..." >> postinst
	echo "apt update" >> postinst
	echo "exit 0" >> postinst
}

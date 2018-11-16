LINUXDROID_PKG_HOMEPAGE=https://linuxdroid-x11.ml
LINUXDROID_PKG_DESCRIPTION="Package repository containing X11 programs and libraries"
LINUXDROID_PKG_MAINTAINER="Leonid Plyushch <leonid.plyushch@gmail.com> @xeffyr"
LINUXDROID_PKG_VERSION=1.2
LINUXDROID_PKG_PLATFORM_INDEPENDENT=yes

linuxdroid_step_make_install() {
	mkdir -p $LINUXDROID_PREFIX/etc/apt/{sources.list.d,trusted.gpg.d}
	echo "deb https://linuxdroid-x11.ml x11 main" > $LINUXDROID_PREFIX/etc/apt/sources.list.d/x11.list
	cp $LINUXDROID_PKG_BUILDER_DIR/xeffyr.gpg $LINUXDROID_PREFIX/etc/apt/trusted.gpg.d/
}

linuxdroid_step_create_debscripts () {
	echo "#!$LINUXDROID_PREFIX/bin/sh" > postinst
	echo "echo Downloading updated package list ..." >> postinst
	echo "apt update" >> postinst
	echo "exit 0" >> postinst
}

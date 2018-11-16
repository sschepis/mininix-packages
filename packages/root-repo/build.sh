LINUXDROID_PKG_HOMEPAGE=https://github.com/linuxdroid/linuxdroid-root-packages
LINUXDROID_PKG_DESCRIPTION="Package repository containing programs for rooted devices"
LINUXDROID_PKG_MAINTAINER="Henrik Grimler @Grimler91"
LINUXDROID_PKG_VERSION=1.1
LINUXDROID_PKG_PLATFORM_INDEPENDENT=yes

linuxdroid_step_make_install() {
	mkdir -p $LINUXDROID_PREFIX/etc/apt/{sources.list.d,trusted.gpg.d}
	echo "deb https://grimler.se root stable" > $LINUXDROID_PREFIX/etc/apt/sources.list.d/root.list
	cp $LINUXDROID_PKG_BUILDER_DIR/grimler.gpg $LINUXDROID_PREFIX/etc/apt/trusted.gpg.d/
}

linuxdroid_step_create_debscripts () {
	echo "#!$LINUXDROID_PREFIX/bin/sh" > postinst
	echo "echo Downloading updated package list ..." >> postinst
	echo "apt update" >> postinst
	echo "exit 0" >> postinst
}

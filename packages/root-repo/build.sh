MININIX_PKG_HOMEPAGE=https://github.com/mininix/mininix-root-packages
MININIX_PKG_DESCRIPTION="Package repository containing programs for rooted devices"
MININIX_PKG_MAINTAINER="Henrik Grimler @Grimler91"
MININIX_PKG_VERSION=1.1
MININIX_PKG_PLATFORM_INDEPENDENT=yes

mininix_step_make_install() {
	mkdir -p $MININIX_PREFIX/etc/apt/{sources.list.d,trusted.gpg.d}
	echo "deb https://grimler.se root stable" > $MININIX_PREFIX/etc/apt/sources.list.d/root.list
	cp $MININIX_PKG_BUILDER_DIR/grimler.gpg $MININIX_PREFIX/etc/apt/trusted.gpg.d/
}

mininix_step_create_debscripts () {
	echo "#!$MININIX_PREFIX/bin/sh" > postinst
	echo "echo Downloading updated package list ..." >> postinst
	echo "apt update" >> postinst
	echo "exit 0" >> postinst
}

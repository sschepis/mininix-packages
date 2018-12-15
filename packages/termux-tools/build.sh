MININIX_PKG_HOMEPAGE=https://mininix.com/
MININIX_PKG_DESCRIPTION="Basic system tools for Mininix"
MININIX_PKG_VERSION=0.58
MININIX_PKG_PLATFORM_INDEPENDENT=yes
MININIX_PKG_ESSENTIAL=yes
MININIX_PKG_DEPENDS="mininix-am"
MININIX_PKG_CONFFILES="etc/motd"
MININIX_PKG_CONFLICTS="procps (<< 3.3.15-2)"

mininix_step_make_install () {
	mkdir -p $MININIX_PREFIX/bin/applets
	# Remove LD_LIBRARY_PATH from environment to avoid conflicting
	# with system libraries that system binaries may link against:
	for tool in df getprop logcat ping ping6 ip pm settings top; do
		WRAPPER_FILE=$MININIX_PREFIX/bin/$tool
		echo '#!/bin/sh' > $WRAPPER_FILE
		echo 'unset LD_LIBRARY_PATH LD_PRELOAD' >> $WRAPPER_FILE
		# Some tools require having /system/bin/app_process in the PATH,
		# at least am&pm on a Nexus 6p running Android 6.0:
		echo -n 'PATH=$PATH:/system/bin ' >> $WRAPPER_FILE
		echo "exec /system/bin/$tool \"\$@\"" >> $WRAPPER_FILE
		chmod +x $WRAPPER_FILE
	done

	cp -p $MININIX_PKG_BUILDER_DIR/{dalvikvm,su,mininix-fix-shebang,mininix-reload-settings,mininix-setup-storage,chsh,mininix-open-url,mininix-wake-lock,mininix-wake-unlock,login,pkg,mininix-open,mininix-info} $MININIX_PREFIX/bin/
	perl -p -i -e "s%\@MININIX_PREFIX\@%${MININIX_PREFIX}%g" $MININIX_PREFIX/bin/dalvikvm

	cp $MININIX_PKG_BUILDER_DIR/motd $MININIX_PREFIX/etc/motd
	cd $MININIX_PREFIX/bin
	ln -s -f mininix-open xdg-open
}

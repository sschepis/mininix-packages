MININIX_PKG_HOMEPAGE=https://busybox.net/
MININIX_PKG_DESCRIPTION="Tiny versions of many common UNIX utilities into a single small executable"
MININIX_PKG_ESSENTIAL=yes
MININIX_PKG_VERSION=1.29.3
MININIX_PKG_REVISION=1
MININIX_PKG_SHA256=97648636e579462296478e0218e65e4bc1e9cd69089a3b1aeb810bff7621efb7
MININIX_PKG_SRCURL=https://busybox.net/downloads/busybox-${MININIX_PKG_VERSION}.tar.bz2
MININIX_PKG_BUILD_IN_SRC=yes

# We replace env in the old coreutils package:
MININIX_PKG_CONFLICTS="coreutils (<< 8.25-4)"

mininix_step_pre_configure () {
	CFLAGS+=" -llog" # Android system liblog.so for syslog
}

mininix_step_configure () {
	cp $MININIX_PKG_BUILDER_DIR/busybox.config .config
	echo "CONFIG_SYSROOT=\"$MININIX_STANDALONE_TOOLCHAIN/sysroot\"" >> .config
	echo "CONFIG_PREFIX=\"$MININIX_PREFIX\"" >> .config
	echo "CONFIG_CROSS_COMPILER_PREFIX=\"${MININIX_HOST_PLATFORM}-\"" >> .config
	echo "CONFIG_FEATURE_CROND_DIR=\"$MININIX_PREFIX/var/spool/cron\"" >> .config
	echo "CONFIG_SV_DEFAULT_SERVICE_DIR=\"$MININIX_PREFIX/var/service\"" >> .config
	make oldconfig
}

mininix_step_post_make_install () {
	if [ "$MININIX_DEBUG" == "true" ]; then
		install busybox_unstripped $PREFIX/bin/busybox
	fi
	# Create symlinks in $PREFIX/bin/applets to $PREFIX/bin/busybox
	rm -Rf $MININIX_PREFIX/bin/applets
	mkdir -p $MININIX_PREFIX/bin/applets
	cd $MININIX_PREFIX/bin/applets
	for f in `cat $MININIX_PKG_SRCDIR/busybox.links`; do ln -s ../busybox `basename $f`; done

	# The 'env' applet is special in that it go into $PREFIX/bin:
	cd $MININIX_PREFIX/bin
	ln -f -s busybox env

	# Install busybox man page
	mkdir -p $MININIX_PREFIX/share/man/man1
	cp $MININIX_PKG_SRCDIR/docs/busybox.1 $MININIX_PREFIX/share/man/man1

	# Needed for 'crontab -e' to work out of the box:
	local _CRONTABS=$MININIX_PREFIX/var/spool/cron/crontabs
	mkdir -p $_CRONTABS
	echo "Used by the busybox crontab and crond tools" > $_CRONTABS/README.mininix

	# Setup some services
	mkdir -p $MININIX_PREFIX/var/service
	cd $MININIX_PREFIX/var/service
	mkdir -p ftpd telnetd
	echo '#!/bin/sh' > ftpd/run
	echo 'exec tcpsvd -vE 0.0.0.0 8021 ftpd /data/data/com.mininix/files/home' >> ftpd/run
	echo '#!/bin/sh' > telnetd/run
	echo 'exec telnetd -F' >> telnetd/run
	chmod +x */run
}


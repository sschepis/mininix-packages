LINUXDROID_PKG_HOMEPAGE=https://github.com/iputils/iputils
LINUXDROID_PKG_DESCRIPTION="Tool to trace the network path to a remote host"
LINUXDROID_PKG_VERSION=20180629
LINUXDROID_PKG_SHA256=da14105291dd491f28ea91ade854ed10aee8ba019641c80eed233de3908be7c5
LINUXDROID_PKG_SRCURL=https://github.com/iputils/iputils/archive/s${LINUXDROID_PKG_VERSION}.tar.gz
LINUXDROID_PKG_BUILD_IN_SRC=yes
LINUXDROID_PKG_DEPENDS="libidn"

linuxdroid_step_configure () {
	return
}

linuxdroid_step_make () {
	return
}

linuxdroid_step_make_install () {
	$CC $CFLAGS $LDFLAGS -lidn -o $LINUXDROID_PREFIX/bin/tracepath tracepath.c
	local MANDIR=$LINUXDROID_PREFIX/share/man/man8
	mkdir -p $MANDIR
	cp $LINUXDROID_PKG_BUILDER_DIR/tracepath.8 $MANDIR/
	# Setup traceroute as an alias for tracepath, since traceroute
	# requires root which most Linuxdroid user does not have, and tracepath
	# is probably good enough for most:
	(cd $LINUXDROID_PREFIX/bin && ln -f -s tracepath traceroute)
	(cd $MANDIR && ln -f -s tracepath.8 traceroute.8)
}

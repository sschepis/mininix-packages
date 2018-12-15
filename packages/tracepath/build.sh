MININIX_PKG_HOMEPAGE=https://github.com/iputils/iputils
MININIX_PKG_DESCRIPTION="Tool to trace the network path to a remote host"
MININIX_PKG_VERSION=20180629
MININIX_PKG_SHA256=da14105291dd491f28ea91ade854ed10aee8ba019641c80eed233de3908be7c5
MININIX_PKG_SRCURL=https://github.com/iputils/iputils/archive/s${MININIX_PKG_VERSION}.tar.gz
MININIX_PKG_BUILD_IN_SRC=yes
MININIX_PKG_DEPENDS="libidn"

mininix_step_configure () {
	return
}

mininix_step_make () {
	return
}

mininix_step_make_install () {
	$CC $CFLAGS $LDFLAGS -lidn -o $MININIX_PREFIX/bin/tracepath tracepath.c
	local MANDIR=$MININIX_PREFIX/share/man/man8
	mkdir -p $MANDIR
	cp $MININIX_PKG_BUILDER_DIR/tracepath.8 $MANDIR/
	# Setup traceroute as an alias for tracepath, since traceroute
	# requires root which most Mininix user does not have, and tracepath
	# is probably good enough for most:
	(cd $MININIX_PREFIX/bin && ln -f -s tracepath traceroute)
	(cd $MANDIR && ln -f -s tracepath.8 traceroute.8)
}

MININIX_PKG_HOMEPAGE=https://pagure.io/mlocate
MININIX_PKG_DESCRIPTION="Tool to find files anywhere in the filesystem based on their name"
# If not linking to libandroid-support we segfault in
# the libc mbsnrtowcs() function when using a wildcard
# like in '*.deb'.
MININIX_PKG_DEPENDS="libandroid-support"
MININIX_PKG_VERSION=0.26
MININIX_PKG_REVISION=3
MININIX_PKG_SRCURL=https://releases.pagure.org/mlocate/mlocate-${MININIX_PKG_VERSION}.tar.xz
MININIX_PKG_SHA256=3063df79fe198fb9618e180c54baf3105b33d88fe602ff2d8570aaf944f1263e

mininix_step_pre_configure() {
	CPPFLAGS+=" -DLINE_MAX=_POSIX2_LINE_MAX"
}

mininix_step_create_debscripts () {
	echo "#!$MININIX_PREFIX/bin/sh" > postinst
	echo "mkdir -p $MININIX_PREFIX/var/mlocate/" >> postinst
        echo "exit 0" >> postinst
        chmod 0755 postinst
}

LINUXDROID_PKG_HOMEPAGE=http://pyropus.ca/software/getmail/
LINUXDROID_PKG_DESCRIPTION="fetchmail replacement relatively easy to configure"
LINUXDROID_PKG_VERSION=5.7
LINUXDROID_PKG_SHA256=2497a669e77c929621826240371b57b8157502bb88ae530c30307b09233afbf9
LINUXDROID_PKG_SRCURL=https://fossies.org/linux/misc/getmail-${LINUXDROID_PKG_VERSION}.tar.gz
LINUXDROID_PKG_DEPENDS="python2"
LINUXDROID_PKG_BUILD_IN_SRC=yes
LINUXDROID_PKG_PLATFORM_INDEPENDENT=yes

linuxdroid_step_make_install () {
        python2 setup.py install --prefix=$LINUXDROID_PREFIX --force
}

linuxdroid_step_post_massage () {
        find . -path '*.pyc' -delete
}

MININIX_PKG_HOMEPAGE=http://pyropus.ca/software/getmail/
MININIX_PKG_DESCRIPTION="fetchmail replacement relatively easy to configure"
MININIX_PKG_VERSION=5.8
MININIX_PKG_SHA256=819441c7e8ef49d7036c2bc83e1568a7184f0393245fe28368a9dd310e63846e
MININIX_PKG_SRCURL=https://fossies.org/linux/misc/getmail-${MININIX_PKG_VERSION}.tar.gz
MININIX_PKG_DEPENDS="python2"
MININIX_PKG_BUILD_IN_SRC=yes
MININIX_PKG_PLATFORM_INDEPENDENT=yes

mininix_step_make_install () {
        python2 setup.py install --prefix=$MININIX_PREFIX --force
}

mininix_step_post_massage () {
        find . -path '*.pyc' -delete
}

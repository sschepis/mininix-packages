LINUXDROID_PKG_HOMEPAGE=https://asciinema.org/
LINUXDROID_PKG_DESCRIPTION="Record and share your terminal sessions, the right way"
LINUXDROID_PKG_VERSION=2.0.1
LINUXDROID_PKG_REVISION=1
LINUXDROID_PKG_SHA256=7087b247dae36d04821197bc14ebd4248049592b299c9878d8953c025ac802e4
LINUXDROID_PKG_SRCURL=https://github.com/asciinema/asciinema/archive/v${LINUXDROID_PKG_VERSION}.tar.gz
LINUXDROID_PKG_BUILD_IN_SRC=yes
LINUXDROID_PKG_PLATFORM_INDEPENDENT=yes
LINUXDROID_PKG_HAS_DEBUG=no
# ncurses-utils for tput which asciinema uses:
LINUXDROID_PKG_DEPENDS="python, ncurses-utils"

linuxdroid_step_make () {
	return
}

linuxdroid_step_make_install () {
	export PYTHONPATH=$LINUXDROID_PREFIX/lib/python3.7/site-packages/
	python3.7 setup.py install --prefix=$LINUXDROID_PREFIX --force
}

linuxdroid_step_post_massage () {
	find . -path '*/__pycache__*' -delete
}

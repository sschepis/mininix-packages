MININIX_PKG_HOMEPAGE=https://asciinema.org/
MININIX_PKG_DESCRIPTION="Record and share your terminal sessions, the right way"
MININIX_PKG_VERSION=2.0.1
MININIX_PKG_REVISION=1
MININIX_PKG_SHA256=7087b247dae36d04821197bc14ebd4248049592b299c9878d8953c025ac802e4
MININIX_PKG_SRCURL=https://github.com/asciinema/asciinema/archive/v${MININIX_PKG_VERSION}.tar.gz
MININIX_PKG_BUILD_IN_SRC=yes
MININIX_PKG_PLATFORM_INDEPENDENT=yes
MININIX_PKG_HAS_DEBUG=no
# ncurses-utils for tput which asciinema uses:
MININIX_PKG_DEPENDS="python, ncurses-utils"

mininix_step_make () {
	return
}

mininix_step_make_install () {
	export PYTHONPATH=$MININIX_PREFIX/lib/python3.7/site-packages/
	python3.7 setup.py install --prefix=$MININIX_PREFIX --force
}

mininix_step_post_massage () {
	find . -path '*/__pycache__*' -delete
}

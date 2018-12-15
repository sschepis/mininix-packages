MININIX_PKG_HOMEPAGE=https://ranger.github.io/
MININIX_PKG_DESCRIPTION="File manager with VI key bindings"
MININIX_PKG_VERSION=1.9.2
MININIX_PKG_REVISION=1
MININIX_PKG_SHA256=49a2d8dc5fa7b1c0cac0fa72d4ad704fc7107dee36cb9feb325a42754774d363
MININIX_PKG_SRCURL=https://github.com/ranger/ranger/archive/v${MININIX_PKG_VERSION}.tar.gz
MININIX_PKG_DEPENDS="python, file"
MININIX_PKG_BUILD_IN_SRC=yes
MININIX_PKG_PLATFORM_INDEPENDENT=yes

mininix_step_make() {
	echo Skipping make step...
}

mininix_step_make_install() {
        python3.7 setup.py install --prefix=$MININIX_PREFIX --force
}

mininix_step_post_massage() {
	find . -path '*/__pycache__*' -delete
}

LINUXDROID_PKG_HOMEPAGE=https://ranger.github.io/
LINUXDROID_PKG_DESCRIPTION="File manager with VI key bindings"
LINUXDROID_PKG_VERSION=1.9.2
LINUXDROID_PKG_REVISION=1
LINUXDROID_PKG_SHA256=49a2d8dc5fa7b1c0cac0fa72d4ad704fc7107dee36cb9feb325a42754774d363
LINUXDROID_PKG_SRCURL=https://github.com/ranger/ranger/archive/v${LINUXDROID_PKG_VERSION}.tar.gz
LINUXDROID_PKG_DEPENDS="python, file"
LINUXDROID_PKG_BUILD_IN_SRC=yes
LINUXDROID_PKG_PLATFORM_INDEPENDENT=yes

linuxdroid_step_make() {
	echo Skipping make step...
}

linuxdroid_step_make_install() {
        python3.7 setup.py install --prefix=$LINUXDROID_PREFIX --force
}

linuxdroid_step_post_massage() {
	find . -path '*/__pycache__*' -delete
}

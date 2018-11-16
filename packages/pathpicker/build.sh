LINUXDROID_PKG_HOMEPAGE=https://facebook.github.io/PathPicker/
LINUXDROID_PKG_DESCRIPTION="Facebook PathPicker - a terminal-based file picker"
LINUXDROID_PKG_VERSION=0.7.2
LINUXDROID_PKG_SRCURL=https://github.com/facebook/PathPicker/archive/${LINUXDROID_PKG_VERSION}.tar.gz
LINUXDROID_PKG_SHA256=e6376fe627474e3e3109f9f913327098e84887fce67a8d1e7d12835ff04ee620
LINUXDROID_PKG_DEPENDS="bash,python"
LINUXDROID_PKG_BUILD_IN_SRC=yes
LINUXDROID_PKG_PLATFORM_INDEPENDENT=yes

linuxdroid_step_make_install () {
	_PKG_DIR=$LINUXDROID_PREFIX/share/pathpicker
	rm -Rf $_PKG_DIR
	mkdir -p $_PKG_DIR
	cp -Rf src/ $_PKG_DIR
	cp fpp $_PKG_DIR/fpp
	cd $LINUXDROID_PREFIX/bin
	ln -f -s ../share/pathpicker/fpp fpp
	chmod +x fpp
}

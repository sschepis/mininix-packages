MININIX_PKG_HOMEPAGE=https://facebook.github.io/PathPicker/
MININIX_PKG_DESCRIPTION="Facebook PathPicker - a terminal-based file picker"
MININIX_PKG_VERSION=0.7.2
MININIX_PKG_SRCURL=https://github.com/facebook/PathPicker/archive/${MININIX_PKG_VERSION}.tar.gz
MININIX_PKG_SHA256=e6376fe627474e3e3109f9f913327098e84887fce67a8d1e7d12835ff04ee620
MININIX_PKG_DEPENDS="bash,python"
MININIX_PKG_BUILD_IN_SRC=yes
MININIX_PKG_PLATFORM_INDEPENDENT=yes

mininix_step_make_install () {
	_PKG_DIR=$MININIX_PREFIX/share/pathpicker
	rm -Rf $_PKG_DIR
	mkdir -p $_PKG_DIR
	cp -Rf src/ $_PKG_DIR
	cp fpp $_PKG_DIR/fpp
	cd $MININIX_PREFIX/bin
	ln -f -s ../share/pathpicker/fpp fpp
	chmod +x fpp
}

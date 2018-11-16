LINUXDROID_PKG_HOMEPAGE=https://pyyaml.org/wiki/LibYAML
LINUXDROID_PKG_DESCRIPTION="LibYAML is a YAML 1.1 parser and emitter written in C"
LINUXDROID_PKG_VERSION=0.2.1
LINUXDROID_PKG_SHA256=1d2aeb87f7d317f1496e4c39410d913840714874a354970300f375eec9303dc4
LINUXDROID_PKG_SRCURL=https://github.com/yaml/libyaml/archive/$LINUXDROID_PKG_VERSION.tar.gz

linuxdroid_step_pre_configure() {
	./bootstrap
}

linuxdroid_step_post_make_install() {
	cd $LINUXDROID_PREFIX/lib
	ln -s -f libyaml-0.so libyaml.so
}

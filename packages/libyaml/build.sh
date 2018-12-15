MININIX_PKG_HOMEPAGE=https://pyyaml.org/wiki/LibYAML
MININIX_PKG_DESCRIPTION="LibYAML is a YAML 1.1 parser and emitter written in C"
MININIX_PKG_VERSION=0.2.1
MININIX_PKG_SHA256=1d2aeb87f7d317f1496e4c39410d913840714874a354970300f375eec9303dc4
MININIX_PKG_SRCURL=https://github.com/yaml/libyaml/archive/$MININIX_PKG_VERSION.tar.gz

mininix_step_pre_configure() {
	./bootstrap
}

mininix_step_post_make_install() {
	cd $MININIX_PREFIX/lib
	ln -s -f libyaml-0.so libyaml.so
}

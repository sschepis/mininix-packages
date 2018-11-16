LINUXDROID_PKG_HOMEPAGE=https://the.exa.website
LINUXDROID_PKG_DESCRIPTION="A modern replacement for ls"
LINUXDROID_PKG_VERSION=0.9~pre1
LINUXDROID_PKG_SHA256=3cec8e192dd5b69e650605a1948832d4d52ad25d37deecb49a180df020449f54
LINUXDROID_PKG_SRCURL=https://github.com/ogham/exa/archive/57e4c08411f59e7db91fa7d8127fbd412667ea32.zip
LINUXDROID_PKG_EXTRA_CONFIGURE_ARGS="--no-default-features --features default"
LINUXDROID_PKG_BUILD_IN_SRC=yes

linuxdroid_step_pre_configure() {
	rm $LINUXDROID_PKG_SRCDIR/Makefile
	linuxdroid_setup_rust
	cargo update
}

linuxdroid_step_post_make_install() {
	mkdir -p $LINUXDROID_PREFIX/share/man/man1
	cp $LINUXDROID_PKG_SRCDIR/contrib/man/exa.1 $LINUXDROID_PREFIX/share/man/man1/
}

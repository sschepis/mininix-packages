MININIX_PKG_HOMEPAGE=https://the.exa.website
MININIX_PKG_DESCRIPTION="A modern replacement for ls"
MININIX_PKG_VERSION=0.9~pre2
MININIX_PKG_SHA256=df558e74aed27425b9dd2fbca4ee14eee672677722b93b77984d1b9b5265e023
MININIX_PKG_SRCURL=https://github.com/ogham/exa/archive/485611e7c97d2043731ae83653a70eee2eb69a4b.zip
MININIX_PKG_EXTRA_CONFIGURE_ARGS="--no-default-features --features default"
MININIX_PKG_BUILD_IN_SRC=yes

mininix_step_pre_configure() {
	rm $MININIX_PKG_SRCDIR/Makefile
	mininix_setup_rust
	cargo update
}

mininix_step_post_make_install() {
	mkdir -p $MININIX_PREFIX/share/man/man1
	cp $MININIX_PKG_SRCDIR/contrib/man/exa.1 $MININIX_PREFIX/share/man/man1/
}

MININIX_PKG_HOMEPAGE=http://joe-editor.sourceforge.net
MININIX_PKG_DESCRIPTION="Wordstar like text editor"
MININIX_PKG_DEPENDS="ncurses, libutil"
MININIX_PKG_CONFLICTS="jupp"
MININIX_PKG_VERSION=4.6
MININIX_PKG_SHA256=495a0a61f26404070fe8a719d80406dc7f337623788e445b92a9f6de512ab9de
MININIX_PKG_SRCURL=https://sourceforge.net/projects/joe-editor/files/JOE%20sources/joe-${MININIX_PKG_VERSION}/joe-${MININIX_PKG_VERSION}.tar.gz
MININIX_PKG_EXTRA_CONFIGURE_ARGS="--disable-termcap"

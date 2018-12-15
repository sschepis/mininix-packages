MININIX_PKG_HOMEPAGE=https://launchpad.net/pastebinit
MININIX_PKG_DESCRIPTION="Command-line pastebin client"
MININIX_PKG_VERSION=1.5
MININIX_PKG_SRCURL=https://launchpad.net/pastebinit/trunk/${MININIX_PKG_VERSION}/+download/pastebinit-${MININIX_PKG_VERSION}.tar.bz2
MININIX_PKG_SHA256=42e5a84ce7e46825fb3b6478e11893fad357197327257e474bd0d3549f438457
MININIX_PKG_DEPENDS="python"
MININIX_PKG_BUILD_IN_SRC=yes
MININIX_PKG_PLATFORM_INDEPENDENT=yes

mininix_step_make_install () {
        cp pastebinit $MININIX_PREFIX/bin/
	xsltproc -''-nonet /usr/share/sgml/docbook/stylesheet/xsl/nwalsh/manpages/docbook.xsl pastebinit.xml
	cp pastebinit.1 $MININIX_PREFIX/share/man/man1/

	rm -Rf $MININIX_PREFIX/etc/pastebin.d
	mv pastebin.d $MININIX_PREFIX/etc
}

LINUXDROID_PKG_HOMEPAGE=https://launchpad.net/pastebinit
LINUXDROID_PKG_DESCRIPTION="Command-line pastebin client"
LINUXDROID_PKG_VERSION=1.5
LINUXDROID_PKG_SRCURL=https://launchpad.net/pastebinit/trunk/${LINUXDROID_PKG_VERSION}/+download/pastebinit-${LINUXDROID_PKG_VERSION}.tar.bz2
LINUXDROID_PKG_SHA256=42e5a84ce7e46825fb3b6478e11893fad357197327257e474bd0d3549f438457
LINUXDROID_PKG_DEPENDS="python"
LINUXDROID_PKG_BUILD_IN_SRC=yes
LINUXDROID_PKG_PLATFORM_INDEPENDENT=yes

linuxdroid_step_make_install () {
        cp pastebinit $LINUXDROID_PREFIX/bin/
	xsltproc -''-nonet /usr/share/sgml/docbook/stylesheet/xsl/nwalsh/manpages/docbook.xsl pastebinit.xml
	cp pastebinit.1 $LINUXDROID_PREFIX/share/man/man1/

	rm -Rf $LINUXDROID_PREFIX/etc/pastebin.d
	mv pastebin.d $LINUXDROID_PREFIX/etc
}

MININIX_PKG_HOMEPAGE=https://nzbget.net/
MININIX_PKG_DESCRIPTION="The most efficient usenet downloader"
MININIX_PKG_VERSION=20.0
MININIX_PKG_REVISION=1
MININIX_PKG_SRCURL=https://github.com/nzbget/nzbget/releases/download/v${MININIX_PKG_VERSION}/nzbget-${MININIX_PKG_VERSION}-src.tar.gz
MININIX_PKG_SHA256=04dc36d432549c33d55145ecd95cc4309b3ab4a7731a1a03d954de389eacd06f
MININIX_PKG_DEPENDS="libxml2, ncurses, openssl, unrar, p7zip"
MININIX_PKG_BUILD_IN_SRC=yes

mininix_step_create_debscripts () {
	echo "#!$MININIX_PREFIX/bin/sh" > postinst
	echo "if [ -z \"\$2\" ]; then" >> postinst # Run only on fresh install, not on upgrade
	echo "sed -e 's|^\(CertStore=\).*|\1$MININIX_PREFIX/etc/tls/cert.pem|g" >> postinst
	echo "s|^\(ControlPassword=\).*|\1|g' $MININIX_PREFIX/share/nzbget/nzbget.conf > $MININIX_PREFIX/etc/nzbget.conf" >> postinst
	echo "fi" >> postinst
	echo "exit 0" >> postinst
	chmod 0755 postinst
}

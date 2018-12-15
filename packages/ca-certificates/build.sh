MININIX_PKG_HOMEPAGE=https://curl.haxx.se/docs/caextract.html
MININIX_PKG_DESCRIPTION="Common CA certificates"
MININIX_PKG_VERSION=20181017
MININIX_PKG_SRCURL=https://curl.haxx.se/ca/cacert.pem
# If the checksum has changed, it may be time to update the package version:
MININIX_PKG_SHA256=86695b1be9225c3cf882d283f05c944e3aabbc1df6428a4424269a93e997dc65
MININIX_PKG_SKIP_SRC_EXTRACT=yes
MININIX_PKG_PLATFORM_INDEPENDENT=yes

mininix_step_make_install () {
	local CERTDIR=$MININIX_PREFIX/etc/tls
	local CERTFILE=$CERTDIR/cert.pem

	mkdir -p $CERTDIR

	mininix_download $MININIX_PKG_SRCURL \
		$CERTFILE \
		$MININIX_PKG_SHA256
	touch $CERTFILE

	# Build java keystore which is split out into a ca-certificates-java subpackage:
	local KEYUTIL_JAR=$MININIX_PKG_CACHEDIR/keyutil-0.4.0.jar
	mininix_download \
		https://github.com/use-sparingly/keyutil/releases/download/0.4.0/keyutil-0.4.0.jar \
		$KEYUTIL_JAR \
		18f1d2c82839d84949b1ad015343c509e81ef678c24db6112acc6c0761314610

	local JAVA_KEYSTORE_DIR=$PREFIX/lib/jvm/openjdk-9/lib/security
	mkdir -p $JAVA_KEYSTORE_DIR

	java -jar $KEYUTIL_JAR \
		--import \
		--new-keystore $JAVA_KEYSTORE_DIR/jssecacerts \
		--password changeit \
		--force-new-overwrite \
		--import-pem-file $CERTFILE
}

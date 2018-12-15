MININIX_PKG_HOMEPAGE=https://httpd.apache.org
MININIX_PKG_DESCRIPTION="Apache Web Server"
MININIX_PKG_VERSION=2.4.37
MININIX_PKG_SHA256=3498dc5c6772fac2eb7307dc7963122ffe243b5e806e0be4fb51974ff759d726
MININIX_PKG_SRCURL=https://www.apache.org/dist/httpd/httpd-$MININIX_PKG_VERSION.tar.bz2
MININIX_PKG_DEPENDS="apr, apr-util, pcre, openssl, libcrypt, libandroid-support, libnghttp2, libexpat"
MININIX_PKG_CONFFILES="
etc/apache2/httpd.conf
etc/apache2/extra/httpd-autoindex.conf
etc/apache2/extra/httpd-dav.conf
etc/apache2/extra/httpd-default.conf
etc/apache2/extra/httpd-info.conf
etc/apache2/extra/httpd-languages.conf
etc/apache2/extra/httpd-manual.conf
etc/apache2/extra/httpd-mpm.conf
etc/apache2/extra/httpd-multilang-errordoc.conf
etc/apache2/extra/httpd-ssl.conf
etc/apache2/extra/httpd-userdir.conf
etc/apache2/extra/httpd-vhosts.conf
etc/apache2/extra/proxy-html.conf
etc/apache2/mime.types
etc/apache2/magic
"
MININIX_PKG_MAINTAINER="Vishal Biswas @vishalbiswas"
# providing manual paths to libs because it picks up host libs on some systems
MININIX_PKG_EXTRA_CONFIGURE_ARGS="
--with-apr=$MININIX_PREFIX
--with-apr-util=$MININIX_PREFIX
--with-pcre=$MININIX_PREFIX
--enable-suexec
--enable-layout=Mininix
--enable-so
--enable-authnz-fcgi
--enable-cache
--enable-disk-cache
--enable-mem-cache
--enable-file-cache
--enable-ssl
--with-ssl
--enable-deflate
--enable-cgi
--enable-cgid
--enable-proxy
--enable-proxy-connect
--enable-proxy-http
--enable-proxy-ftp
--enable-dbd
--enable-imagemap
--enable-ident
--enable-cern-meta
--enable-http2
--enable-mpms-shared=all
--enable-modules=all
--enable-mods-shared=all
--disable-brotli
--disable-lua
--disable-mods-static
--disable-md
--with-port=8080
--with-sslport=8443
--enable-unixd
--without-libxml2
--libexecdir=$MININIX_PREFIX/libexec/apache2
ac_cv_func_getpwnam=yes
ac_cv_have_threadsafe_pollset=no
"
MININIX_PKG_BUILD_IN_SRC=true
MININIX_PKG_RM_AFTER_INSTALL="share/apache2/manual etc/apache2/original share/man/man8/suexec.8 libexec/httpd.exp"
MININIX_PKG_INCLUDE_IN_DEVPACKAGE="share/apache2/build"
MININIX_PKG_EXTRA_MAKE_ARGS="-s"

mininix_step_pre_configure () {
	# remove old files
	rm -rf "$MININIX_PREFIX"/{libexec,share,etc}/apache2
	rm -rf "$MININIX_PREFIX"/lib/cgi-bin

	if [ $MININIX_ARCH_BITS -eq 32 ]; then
		export ap_cv_void_ptr_lt_long=4
	else
		export ap_cv_void_ptr_lt_long=8
	fi

	LDFLAGS="$LDFLAGS -llog -lapr-1 -laprutil-1"

	# use custom layout
	cat $MININIX_PKG_BUILDER_DIR/Mininix.layout > $MININIX_PKG_SRCDIR/config.layout
}

mininix_step_post_configure () {
	# thanks to @JetBalsa
	gcc -O2 -DCROSS_COMPILE $MININIX_PKG_SRCDIR/server/gen_test_char.c -o $MININIX_PKG_BUILDDIR/server/gen_test_char
	touch -d "1 hour" $MININIX_PKG_BUILDDIR/server/gen_test_char
}

mininix_step_post_make_install () {
	sed -e "s#/$MININIX_PREFIX/libexec/apache2/#modules/#" \
		-e 's|#\(LoadModule negotiation_module \)|\1|' \
		-e 's|#\(LoadModule include_module \)|\1|' \
		-e 's|#\(LoadModule userdir_module \)|\1|' \
		-e 's|#\(LoadModule slotmem_shm_module \)|\1|' \
		-e 's|#\(Include extra/httpd-multilang-errordoc.conf\)|\1|' \
		-e 's|#\(Include extra/httpd-autoindex.conf\)|\1|' \
		-e 's|#\(Include extra/httpd-languages.conf\)|\1|' \
		-e 's|#\(Include extra/httpd-userdir.conf\)|\1|' \
		-e 's|#\(Include extra/httpd-default.conf\)|\1|' \
		-e 's|#\(Include extra/httpd-mpm.conf\)|\1|' \
		-e 's|User daemon|#User daemon|' \
		-e 's|Group daemon|#Group daemon|' \
		-i "$MININIX_PREFIX/etc/apache2/httpd.conf"
}

mininix_step_post_massage () {
	# sometimes it creates a $MININIX_PREFIX/bin/sh -> /bin/sh
	rm ${MININIX_PKG_MASSAGEDIR}${MININIX_PREFIX}/bin/sh || true

	mkdir -p ${MININIX_PKG_MASSAGEDIR}${MININIX_PREFIX}/var/run/apache2
	mkdir -p ${MININIX_PKG_MASSAGEDIR}${MININIX_PREFIX}/var/log/apache2
}

LINUXDROID_PKG_HOMEPAGE=https://www.nginx.org
LINUXDROID_PKG_DESCRIPTION="Lightweight HTTP server"
LINUXDROID_PKG_VERSION=1.15.6
LINUXDROID_PKG_SHA256=a3d8c67c2035808c7c0d475fffe263db8c353b11521aa7ade468b780ed826cc6
LINUXDROID_PKG_SRCURL=http://nginx.org/download/nginx-$LINUXDROID_PKG_VERSION.tar.gz
LINUXDROID_PKG_BUILD_IN_SRC=true
LINUXDROID_PKG_DEPENDS="libandroid-glob, libcrypt, pcre, openssl"
LINUXDROID_PKG_CONFFILES="etc/nginx/fastcgi.conf etc/nginx/fastcgi_params etc/nginx/koi-win etc/nginx/koi-utf
etc/nginx/mime.types etc/nginx/nginx.conf etc/nginx/scgi_params etc/nginx/uwsgi_params etc/nginx/win-utf"
LINUXDROID_PKG_MAINTAINER="Vishal Biswas @vishalbiswas"

linuxdroid_step_pre_configure () {
	CPPFLAGS="$CPPFLAGS -DIOV_MAX=1024"
	LDFLAGS="$LDFLAGS -landroid-glob"

	# remove config from previouse installs
	rm -rf "$LINUXDROID_PREFIX/etc/nginx"
}

linuxdroid_step_configure () {
	DEBUG_FLAG=""
	test -n "$LINUXDROID_DEBUG" && DEBUG_FLAG="--with-debug"

	./configure \
		--prefix=$LINUXDROID_PREFIX \
		--crossbuild="Linux:3.16.1:$LINUXDROID_ARCH" \
		--crossfile="$LINUXDROID_PKG_SRCDIR/auto/cross/Android" \
		--with-cc=$CC \
		--with-cpp=$CPP \
		--with-cc-opt="$CPPFLAGS $CFLAGS" \
		--with-ld-opt="$LDFLAGS" \
		--with-pcre \
		--with-pcre-jit \
		--with-threads \
		--with-ipv6 \
		--sbin-path="$LINUXDROID_PREFIX/bin/nginx" \
		--conf-path="$LINUXDROID_PREFIX/etc/nginx/nginx.conf" \
		--http-log-path="$LINUXDROID_PREFIX/var/log/nginx/access.log" \
		--pid-path="$LINUXDROID_PREFIX/tmp/nginx.pid" \
		--lock-path="$LINUXDROID_PREFIX/tmp/nginx.lock" \
		--error-log-path="$LINUXDROID_PREFIX/var/log/nginx/error.log" \
		--http-client-body-temp-path="$LINUXDROID_PREFIX/var/lib/nginx/client-body" \
		--http-proxy-temp-path="$LINUXDROID_PREFIX/var/lib/nginx/proxy" \
		--http-fastcgi-temp-path="$LINUXDROID_PREFIX/var/lib/nginx/fastcgi" \
		--http-scgi-temp-path="$LINUXDROID_PREFIX/var/lib/nginx/scgi" \
		--http-uwsgi-temp-path="$LINUXDROID_PREFIX/var/lib/nginx/uwsgi" \
		--with-http_auth_request_module \
		--with-http_ssl_module \
		--with-http_v2_module \
		--with-http_gunzip_module \
		$DEBUG_FLAG
}

linuxdroid_step_post_make_install () {
	# many parts are taken directly from Arch PKGBUILD
	# https://git.archlinux.org/svntogit/packages.git/tree/trunk/PKGBUILD?h=packages/nginx

	# set default port to 8080
	sed -i "s| 80;| 8080;|" "$LINUXDROID_PREFIX/etc/nginx/nginx.conf"
	cp conf/mime.types "$LINUXDROID_PREFIX/etc/nginx/"
	rm "$LINUXDROID_PREFIX"/etc/nginx/*.default

	# move default html dir
	sed -e "44s|html|$LINUXDROID_PREFIX/share/nginx/html|" \
		-e "54s|html|$LINUXDROID_PREFIX/share/nginx/html|" \
		-i "$LINUXDROID_PREFIX/etc/nginx/nginx.conf"
	rm -rf "$LINUXDROID_PREFIX/share/nginx"
	mkdir -p "$LINUXDROID_PREFIX/share/nginx"
	mv "$LINUXDROID_PREFIX/html/" "$LINUXDROID_PREFIX/share/nginx"

	# install vim contrib
	for i in ftdetect indent syntax; do
		install -Dm644 "$LINUXDROID_PKG_SRCDIR/contrib/vim/${i}/nginx.vim" \
			"$LINUXDROID_PREFIX/share/vim/vimfiles/${i}/nginx.vim"
	done

	# install man pages
	mkdir -p "$LINUXDROID_PREFIX/share/man/man8"
	cp "$LINUXDROID_PKG_SRCDIR/man/nginx.8" "$LINUXDROID_PREFIX/share/man/man8/"
}

linuxdroid_step_post_massage () {
	# keep empty dirs which were deleted in massage
	mkdir -p "$LINUXDROID_PKG_MASSAGEDIR/$LINUXDROID_PREFIX/var/log/nginx"
	for dir in client-body proxy fastcgi scgi uwsgi; do
		mkdir -p "$LINUXDROID_PKG_MASSAGEDIR/$LINUXDROID_PREFIX/var/lib/nginx/$dir"
	done
}


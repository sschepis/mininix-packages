MININIX_PKG_HOMEPAGE=https://www.nginx.org
MININIX_PKG_DESCRIPTION="Lightweight HTTP server"
MININIX_PKG_VERSION=1.15.7
MININIX_PKG_SHA256=8f22ea2f6c0e0a221b6ddc02b6428a3ff708e2ad55f9361102b1c9f4142bdf93
MININIX_PKG_SRCURL=http://nginx.org/download/nginx-$MININIX_PKG_VERSION.tar.gz
MININIX_PKG_BUILD_IN_SRC=true
MININIX_PKG_DEPENDS="libandroid-glob, libcrypt, pcre, openssl"
MININIX_PKG_CONFFILES="etc/nginx/fastcgi.conf etc/nginx/fastcgi_params etc/nginx/koi-win etc/nginx/koi-utf
etc/nginx/mime.types etc/nginx/nginx.conf etc/nginx/scgi_params etc/nginx/uwsgi_params etc/nginx/win-utf"
MININIX_PKG_MAINTAINER="Vishal Biswas @vishalbiswas"

mininix_step_pre_configure () {
	CPPFLAGS="$CPPFLAGS -DIOV_MAX=1024"
	LDFLAGS="$LDFLAGS -landroid-glob"

	# remove config from previouse installs
	rm -rf "$MININIX_PREFIX/etc/nginx"
}

mininix_step_configure () {
	DEBUG_FLAG=""
	test -n "$MININIX_DEBUG" && DEBUG_FLAG="--with-debug"

	./configure \
		--prefix=$MININIX_PREFIX \
		--crossbuild="Linux:3.16.1:$MININIX_ARCH" \
		--crossfile="$MININIX_PKG_SRCDIR/auto/cross/Android" \
		--with-cc=$CC \
		--with-cpp=$CPP \
		--with-cc-opt="$CPPFLAGS $CFLAGS" \
		--with-ld-opt="$LDFLAGS" \
		--with-pcre \
		--with-pcre-jit \
		--with-threads \
		--with-ipv6 \
		--sbin-path="$MININIX_PREFIX/bin/nginx" \
		--conf-path="$MININIX_PREFIX/etc/nginx/nginx.conf" \
		--http-log-path="$MININIX_PREFIX/var/log/nginx/access.log" \
		--pid-path="$MININIX_PREFIX/tmp/nginx.pid" \
		--lock-path="$MININIX_PREFIX/tmp/nginx.lock" \
		--error-log-path="$MININIX_PREFIX/var/log/nginx/error.log" \
		--http-client-body-temp-path="$MININIX_PREFIX/var/lib/nginx/client-body" \
		--http-proxy-temp-path="$MININIX_PREFIX/var/lib/nginx/proxy" \
		--http-fastcgi-temp-path="$MININIX_PREFIX/var/lib/nginx/fastcgi" \
		--http-scgi-temp-path="$MININIX_PREFIX/var/lib/nginx/scgi" \
		--http-uwsgi-temp-path="$MININIX_PREFIX/var/lib/nginx/uwsgi" \
		--with-http_auth_request_module \
		--with-http_ssl_module \
		--with-http_v2_module \
		--with-http_gunzip_module \
		$DEBUG_FLAG
}

mininix_step_post_make_install () {
	# many parts are taken directly from Arch PKGBUILD
	# https://git.archlinux.org/svntogit/packages.git/tree/trunk/PKGBUILD?h=packages/nginx

	# set default port to 8080
	sed -i "s| 80;| 8080;|" "$MININIX_PREFIX/etc/nginx/nginx.conf"
	cp conf/mime.types "$MININIX_PREFIX/etc/nginx/"
	rm "$MININIX_PREFIX"/etc/nginx/*.default

	# move default html dir
	sed -e "44s|html|$MININIX_PREFIX/share/nginx/html|" \
		-e "54s|html|$MININIX_PREFIX/share/nginx/html|" \
		-i "$MININIX_PREFIX/etc/nginx/nginx.conf"
	rm -rf "$MININIX_PREFIX/share/nginx"
	mkdir -p "$MININIX_PREFIX/share/nginx"
	mv "$MININIX_PREFIX/html/" "$MININIX_PREFIX/share/nginx"

	# install vim contrib
	for i in ftdetect indent syntax; do
		install -Dm644 "$MININIX_PKG_SRCDIR/contrib/vim/${i}/nginx.vim" \
			"$MININIX_PREFIX/share/vim/vimfiles/${i}/nginx.vim"
	done

	# install man pages
	mkdir -p "$MININIX_PREFIX/share/man/man8"
	cp "$MININIX_PKG_SRCDIR/man/nginx.8" "$MININIX_PREFIX/share/man/man8/"
}

mininix_step_post_massage () {
	# keep empty dirs which were deleted in massage
	mkdir -p "$MININIX_PKG_MASSAGEDIR/$MININIX_PREFIX/var/log/nginx"
	for dir in client-body proxy fastcgi scgi uwsgi; do
		mkdir -p "$MININIX_PKG_MASSAGEDIR/$MININIX_PREFIX/var/lib/nginx/$dir"
	done
}


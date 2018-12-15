MININIX_PKG_HOMEPAGE=https://mariadb.org
MININIX_PKG_DESCRIPTION="A drop-in replacement for mysql server"
MININIX_PKG_VERSION=10.3.11
MININIX_PKG_SHA256=211655b794c9d5397ba3be6c90737eac02e882f296268299239db47ba328f1b2
MININIX_PKG_SRCURL=https://ftp.osuosl.org/pub/mariadb/mariadb-$MININIX_PKG_VERSION/source/mariadb-$MININIX_PKG_VERSION.tar.gz
MININIX_PKG_EXTRA_CONFIGURE_ARGS="
-DBISON_EXECUTABLE=`which bison`
-DGETCONF=`which getconf`
-DBUILD_CONFIG=mysql_release
-DCAT_EXECUTABLE=`which cat`
-DGIT_EXECUTABLE=`which git`
-DGSSAPI_FOUND=NO
-DGRN_WITH_LZ4=no
-DENABLED_LOCAL_INFILE=ON
-DHAVE_UCONTEXT_H=False
-DIMPORT_EXECUTABLES=$MININIX_PKG_HOSTBUILD_DIR/import_executables.cmake
-DINSTALL_LAYOUT=DEB
-DINSTALL_UNIX_ADDRDIR=$MININIX_PREFIX/tmp/mysqld.sock
-DINSTALL_SBINDIR=$MININIX_PREFIX/bin
-DMYSQL_DATADIR=$MININIX_PREFIX/var/lib/mysql
-DPLUGIN_AUTH_GSSAPI_CLIENT=OFF
-DPLUGIN_AUTH_GSSAPI=NO
-DPLUGIN_CONNECT=NO
-DPLUGIN_DAEMON_EXAMPLE=NO
-DPLUGIN_EXAMPLE=NO
-DPLUGIN_GSSAPI=OFF
-DPLUGIN_ROCKSDB=NO
-DPLUGIN_TOKUDB=NO
-DPLUGIN_SERVER_AUDIT=NO
-DSTACK_DIRECTION=-1
-DTMPDIR=$MININIX_PREFIX/tmp
-DWITH_EXTRA_CHARSETS=complex
-DWITH_JEMALLOC=OFF
-DWITH_MARIABACKUP=OFF
-DWITH_PCRE=system
-DWITH_READLINE=OFF
-DWITH_SSL=system
-DWITH_WSREP=False
-DWITH_ZLIB=system
-DWITH_INNODB_BZIP2=OFF
-DWITH_INNODB_LZ4=OFF
-DWITH_INNODB_LZMA=ON
-DWITH_INNODB_LZO=OFF
-DWITH_INNODB_SNAPPY=OFF
-DWITH_UNIT_TESTS=OFF
-DINSTALL_SYSCONFDIR=$MININIX_PREFIX/etc
"
MININIX_PKG_HOSTBUILD=true
MININIX_PKG_DEPENDS="liblzma, ncurses, libedit, openssl, pcre, libcrypt, libandroid-support, libandroid-glob"
MININIX_PKG_MAINTAINER="Vishal Biswas @vishalbiswas"
MININIX_PKG_CONFLICTS="mysql"
MININIX_PKG_RM_AFTER_INSTALL="bin/mysqltest*"

mininix_step_host_build () {
	mininix_setup_cmake
	cmake -G "Unix Makefiles" \
		$MININIX_PKG_SRCDIR \
		-DWITH_SSL=bundled \
		-DCMAKE_BUILD_TYPE=Release
	make -j $MININIX_MAKE_PROCESSES import_executables
}

mininix_step_pre_configure () {
	CPPFLAGS+=" -Dushort=u_short"

	if [ $MININIX_ARCH_BITS = 32 ]; then
		CPPFLAGS+=" -D__off64_t_defined -DMININIX_EXPOSE_FILE_OFFSET64=1"
	fi

	if [ $MININIX_ARCH = "i686" ]; then
		# Avoid undefined reference to __atomic_load_8:
		CFLAGS+=" -latomic"
	fi
}

mininix_step_post_make_install () {
	# files not needed
	rm -r $MININIX_PREFIX/{mysql-test,sql-bench}
	rm $MININIX_PREFIX/share/man/man1/mysql-test-run.pl.1
}

mininix_step_create_debscripts () {
	echo "if [ ! -e "$MININIX_PREFIX/var/lib/mysql" ]; then" > postinst
	echo "  echo 'Initializing mysql data directory...'" >> postinst
	echo "  mkdir -p $MININIX_PREFIX/var/lib/mysql" >> postinst
	echo "  $MININIX_PREFIX/bin/mysql_install_db --user=\`whoami\` --datadir=$MININIX_PREFIX/var/lib/mysql --basedir=$MININIX_PREFIX" >> postinst
	echo "fi" >> postinst
	echo "exit 0" >> postinst
	chmod 0755 postinst
}

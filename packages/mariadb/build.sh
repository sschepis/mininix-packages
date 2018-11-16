LINUXDROID_PKG_HOMEPAGE=https://mariadb.org
LINUXDROID_PKG_DESCRIPTION="A drop-in replacement for mysql server"
LINUXDROID_PKG_VERSION=10.3.10
LINUXDROID_PKG_SHA256=57767c048982811c7ab21d8527f6f36aa897386e8c7235f11b5505a924d68eda
LINUXDROID_PKG_SRCURL=https://ftp.osuosl.org/pub/mariadb/mariadb-$LINUXDROID_PKG_VERSION/source/mariadb-$LINUXDROID_PKG_VERSION.tar.gz
LINUXDROID_PKG_EXTRA_CONFIGURE_ARGS="
-DBISON_EXECUTABLE=`which bison`
-DGETCONF=`which getconf`
-DBUILD_CONFIG=mysql_release
-DCAT_EXECUTABLE=`which cat`
-DGIT_EXECUTABLE=`which git`
-DGSSAPI_FOUND=NO
-DGRN_WITH_LZ4=no
-DENABLED_LOCAL_INFILE=ON
-DHAVE_UCONTEXT_H=False
-DIMPORT_EXECUTABLES=$LINUXDROID_PKG_HOSTBUILD_DIR/import_executables.cmake
-DINSTALL_LAYOUT=DEB
-DINSTALL_UNIX_ADDRDIR=$LINUXDROID_PREFIX/tmp/mysqld.sock
-DINSTALL_SBINDIR=$LINUXDROID_PREFIX/bin
-DMYSQL_DATADIR=$LINUXDROID_PREFIX/var/lib/mysql
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
-DTMPDIR=$LINUXDROID_PREFIX/tmp
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
-DINSTALL_SYSCONFDIR=$LINUXDROID_PREFIX/etc
"
LINUXDROID_PKG_HOSTBUILD=true
LINUXDROID_PKG_DEPENDS="liblzma, ncurses, libedit, openssl, pcre, libcrypt, libandroid-support, libandroid-glob"
LINUXDROID_PKG_MAINTAINER="Vishal Biswas @vishalbiswas"
LINUXDROID_PKG_CONFLICTS="mysql"
LINUXDROID_PKG_RM_AFTER_INSTALL="bin/mysqltest*"

linuxdroid_step_host_build () {
	linuxdroid_setup_cmake
	cmake -G "Unix Makefiles" \
		$LINUXDROID_PKG_SRCDIR \
		-DWITH_SSL=bundled \
		-DCMAKE_BUILD_TYPE=Release
	make -j $LINUXDROID_MAKE_PROCESSES import_executables
}

linuxdroid_step_pre_configure () {
	CPPFLAGS+=" -Dushort=u_short"

	if [ $LINUXDROID_ARCH_BITS = 32 ]; then
		CPPFLAGS+=" -D__off64_t_defined -DLINUXDROID_EXPOSE_FILE_OFFSET64=1"
	fi

	if [ $LINUXDROID_ARCH = "i686" ]; then
		# Avoid undefined reference to __atomic_load_8:
		CFLAGS+=" -latomic"
	fi
}

linuxdroid_step_post_make_install () {
	# files not needed
	rm -r $LINUXDROID_PREFIX/{mysql-test,sql-bench}
	rm $LINUXDROID_PREFIX/share/man/man1/mysql-test-run.pl.1
}

linuxdroid_step_create_debscripts () {
	echo "if [ ! -e "$LINUXDROID_PREFIX/var/lib/mysql" ]; then" > postinst
	echo "  echo 'Initializing mysql data directory...'" >> postinst
	echo "  mkdir -p $LINUXDROID_PREFIX/var/lib/mysql" >> postinst
	echo "  $LINUXDROID_PREFIX/bin/mysql_install_db --user=\`whoami\` --datadir=$LINUXDROID_PREFIX/var/lib/mysql --basedir=$LINUXDROID_PREFIX" >> postinst
	echo "fi" >> postinst
	echo "exit 0" >> postinst
	chmod 0755 postinst
}

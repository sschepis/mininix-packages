LINUXDROID_PKG_HOMEPAGE=https://www.ruby-lang.org/
LINUXDROID_PKG_DESCRIPTION="Dynamic programming language with a focus on simplicity and productivity"
_MAJOR_VERSION=2.5
LINUXDROID_PKG_VERSION=${_MAJOR_VERSION}.3
LINUXDROID_PKG_SHA256=1cc9d0359a8ea35fc6111ec830d12e60168f3b9b305a3c2578357d360fcf306f
LINUXDROID_PKG_SRCURL=https://cache.ruby-lang.org/pub/ruby/${_MAJOR_VERSION}/ruby-${LINUXDROID_PKG_VERSION}.tar.xz
# libbffi is used by the fiddle extension module:
LINUXDROID_PKG_DEPENDS="libandroid-support, libffi, libgmp, readline, openssl, libutil, libyaml"
# Needed to fix compilation on android:
LINUXDROID_PKG_EXTRA_CONFIGURE_ARGS="ac_cv_func_setgroups=no ac_cv_func_setresuid=no ac_cv_func_setreuid=no --enable-rubygems"
# The gdbm module seems to be very little used:
LINUXDROID_PKG_EXTRA_CONFIGURE_ARGS+=" --without-gdbm"
# Do not link in libcrypt.so if available (now in disabled-packages):
LINUXDROID_PKG_EXTRA_CONFIGURE_ARGS+=" ac_cv_lib_crypt_crypt=no"
# Fix DEPRECATED_TYPE macro clang compatibility:
LINUXDROID_PKG_EXTRA_CONFIGURE_ARGS+=" rb_cv_type_deprecated=x"
# getresuid(2) does not work on ChromeOS - https://github.com/linuxdroid/linuxdroid-app/issues/147:
# LINUXDROID_PKG_EXTRA_CONFIGURE_ARGS+=" ac_cv_func_getresuid=no"

linuxdroid_step_pre_configure() {
	if [ "$LINUXDROID_ARCH_BITS" = 32 ]; then
		# process.c:function timetick2integer: error: undefined reference to '__mulodi4'
		LINUXDROID_PKG_EXTRA_CONFIGURE_ARGS+=" rb_cv_builtin___builtin_mul_overflow=no"
	fi
}

linuxdroid_step_make_install () {
	make install
	make uninstall # remove possible remains to get fresh timestamps
	make install

	local RBCONFIG=$LINUXDROID_PREFIX/lib/ruby/${_MAJOR_VERSION}.0/${LINUXDROID_HOST_PLATFORM}/rbconfig.rb

	# Fix absolute paths to executables:
	perl -p -i -e 's/^.*CONFIG\["INSTALL"\].*$/  CONFIG["INSTALL"] = "install -c"/' $RBCONFIG
	perl -p -i -e 's/^.*CONFIG\["PKG_CONFIG"\].*$/  CONFIG["PKG_CONFIG"] = "pkg-config"/' $RBCONFIG
	perl -p -i -e 's/^.*CONFIG\["MAKEDIRS"\].*$/  CONFIG["MAKEDIRS"] = "mkdir -p"/' $RBCONFIG
	perl -p -i -e 's/^.*CONFIG\["MKDIR_P"\].*$/  CONFIG["MKDIR_P"] = "mkdir -p"/' $RBCONFIG
	perl -p -i -e 's/^.*CONFIG\["EGREP"\].*$/  CONFIG["EGREP"] = "grep -E"/' $RBCONFIG
	perl -p -i -e 's/^.*CONFIG\["GREP"\].*$/  CONFIG["GREP"] = "grep"/' $RBCONFIG
}

linuxdroid_step_post_massage () {
	if [ ! -f $LINUXDROID_PREFIX/lib/ruby/${_MAJOR_VERSION}.0/${LINUXDROID_HOST_PLATFORM}/readline.so ]; then
		echo "Error: The readline extension was not built"
	fi
}

MININIX_PKG_HOMEPAGE=https://github.com/vanhauser-thc/thc-hydra
MININIX_PKG_DESCRIPTION="Network logon cracker supporting different services"
MININIX_PKG_VERSION=8.6.20180104
MININIX_PKG_REVISION=1
MININIX_PKG_SHA256=794e5e10e32c9ef3eaf20bbefc0348b997bbb3824dda6de3b5aab91f49beec31
MININIX_PKG_SRCURL=https://github.com/vanhauser-thc/thc-hydra/archive/9597bafb178a57f839502abdd3d62b0b43028993.zip
MININIX_PKG_BUILD_IN_SRC=yes
MININIX_PKG_DEPENDS="openssl, pcre, libssh"

mininix_step_configure() {
	# Skip the ./configure file (which does not support cross compilation)
	# and configure the build manually.
	CFLAGS+=" -Dindex=strchr -DLIBOPENSSL -DNO_RINDEX -DHAVE_MATH_H -DHAVE_PCRE -DLIBSSH"
	export MANDIR=/share/man/man1
	export XLIBS="-lcrypto -lssl -lpcre -lssh"
	cat Makefile.am | sed 's/^install:.*/install: all/'  >> Makefile
}

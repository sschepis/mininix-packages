LINUXDROID_SUBPKG_INCLUDE="bin/gpgv share/man/man1/gpgv.1"
LINUXDROID_SUBPKG_DESCRIPTION="GNU privacy guard - signature verification tool"
# Conflict with older gnupg package before splitting out gpgv:
LINUXDROID_SUBPKG_CONFLICTS="gnupg (<= 1.4.21)"
LINUXDROID_SUBPKG_DEPENDS="libbz2, libgcrypt, libgpg-error"

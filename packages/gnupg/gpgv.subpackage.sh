MININIX_SUBPKG_INCLUDE="bin/gpgv share/man/man1/gpgv.1"
MININIX_SUBPKG_DESCRIPTION="GNU privacy guard - signature verification tool"
# Conflict with older gnupg package before splitting out gpgv:
MININIX_SUBPKG_CONFLICTS="gnupg (<= 1.4.21)"
MININIX_SUBPKG_DEPENDS="libbz2, libgcrypt, libgpg-error"

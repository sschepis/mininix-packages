MININIX_PKG_HOMEPAGE=https://github.com/mininix/mininix-elf-cleaner
MININIX_PKG_DESCRIPTION="Cleaner of ELF files for Android"
# NOTE: The mininix-elf-cleaner.cpp file is used by build-package.sh
#       to create a native binary. Bumping this version will need
#       updating the checksum used there.
MININIX_PKG_VERSION=1.2
MININIX_PKG_SRCURL=https://github.com/mininix/mininix-elf-cleaner/archive/v${MININIX_PKG_VERSION}.tar.gz
MININIX_PKG_SHA256=956d35778bf40523543a98ecec79d7d895a08ac69da1018acb84658a1c94e82b
MININIX_PKG_BUILD_IN_SRC=yes

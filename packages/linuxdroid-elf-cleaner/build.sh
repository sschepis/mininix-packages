LINUXDROID_PKG_HOMEPAGE=https://github.com/linuxdroid/linuxdroid-elf-cleaner
LINUXDROID_PKG_DESCRIPTION="Cleaner of ELF files for Android"
# NOTE: The linuxdroid-elf-cleaner.cpp file is used by build-package.sh
#       to create a native binary. Bumping this version will need
#       updating the checksum used there.
LINUXDROID_PKG_VERSION=1.2
LINUXDROID_PKG_SRCURL=https://github.com/linuxdroid/linuxdroid-elf-cleaner/archive/v${LINUXDROID_PKG_VERSION}.tar.gz
LINUXDROID_PKG_SHA256=956d35778bf40523543a98ecec79d7d895a08ac69da1018acb84658a1c94e82b
LINUXDROID_PKG_BUILD_IN_SRC=yes

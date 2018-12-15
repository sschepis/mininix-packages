MININIX_PKG_HOMEPAGE=https://nixos.org/patchelf.html
MININIX_PKG_DESCRIPTION="Utility to modify the dynamic linker and RPATH of ELF executables"
# Using a git snapshot to fix https://github.com/mininix/mininix-packages/issues/1706.
MININIX_PKG_VERSION=0.9.0.1
MININIX_PKG_REVISION=1
MININIX_PKG_SHA256=fbf494896e3bb8cef9c47b8c3f4d6d387ab19ff4161b61a8fafbcf7395f960a2
MININIX_PKG_SRCURL=https://github.com/NixOS/patchelf/archive/29c085fd9d3fc972f75b3961905d6b4ecce7eb2b.zip
MININIX_PKG_BUILD_IN_SRC=yes

mininix_step_pre_configure () {
	./bootstrap.sh
}

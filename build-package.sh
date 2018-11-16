#!/bin/bash
# shellcheck disable=SC1117

set -e -o pipefail -u

# Utility function to log an error message and exit with an error code.
linuxdroid_error_exit() {
	echo "ERROR: $*" 1>&2
	exit 1
}

if [ "$(uname -o)" = Android ]; then
	linuxdroid_error_exit "On-device builds are not supported - see README.md"
fi

# Utility function to download a resource with an expected checksum.
linuxdroid_download() {
	if [ $# != 3 ]; then
		linuxdroid_error_exit "linuxdroid_download(): Invalid arguments - expected \$URL \$DESTINATION \$CHECKSUM"
	fi
	local URL="$1"
	local DESTINATION="$2"
	local CHECKSUM="$3"

	if [ -f "$DESTINATION" ] && [ "$CHECKSUM" != "SKIP_CHECKSUM" ]; then
		# Keep existing file if checksum matches.
		local EXISTING_CHECKSUM
		EXISTING_CHECKSUM=$(sha256sum "$DESTINATION" | cut -f 1 -d ' ')
		if [ "$EXISTING_CHECKSUM" = "$CHECKSUM" ]; then return; fi
	fi

	local TMPFILE
	TMPFILE=$(mktemp "$LINUXDROID_PKG_TMPDIR/download.$LINUXDROID_PKG_NAME.XXXXXXXXX")
	echo "Downloading ${URL}"
	local TRYMAX=6
	for try in $(seq 1 $TRYMAX); do
		if curl -L --fail --retry 2 -o "$TMPFILE" "$URL"; then
			local ACTUAL_CHECKSUM
			ACTUAL_CHECKSUM=$(sha256sum "$TMPFILE" | cut -f 1 -d ' ')
			if [ "$CHECKSUM" != "SKIP_CHECKSUM" ]; then
				if [ "$CHECKSUM" != "$ACTUAL_CHECKSUM" ]; then
					>&2 printf "Wrong checksum for %s:\nExpected: %s\nActual:   %s\n" \
					           "$URL" "$CHECKSUM" "$ACTUAL_CHECKSUM"
					exit 1
				fi
			else
				printf "WARNING: No checksum check for %s:\nActual: %s\n" \
				       "$URL" "$ACTUAL_CHECKSUM"
			fi
			mv "$TMPFILE" "$DESTINATION"
			return
		else
			echo "Download of $URL failed (attempt $try/$TRYMAX)" 1>&2
			sleep 45
		fi
	done

	linuxdroid_error_exit "Failed to download $URL"
}

# Utility function for golang-using packages to setup a go toolchain.
linuxdroid_setup_golang() {
	export GOOS=android
	export CGO_ENABLED=1
	export GO_LDFLAGS="-extldflags=-pie"
	if [ "$LINUXDROID_ARCH" = "arm" ]; then
		export GOARCH=arm
		export GOARM=7
	elif [ "$LINUXDROID_ARCH" = "i686" ]; then
		export GOARCH=386
		export GO386=sse2
	elif [ "$LINUXDROID_ARCH" = "aarch64" ]; then
		export GOARCH=arm64
	elif [ "$LINUXDROID_ARCH" = "x86_64" ]; then
		export GOARCH=amd64
	else
		linuxdroid_error_exit "Unsupported arch: $LINUXDROID_ARCH"
	fi

	local LINUXDROID_GO_VERSION=go1.11.2
	local LINUXDROID_GO_PLATFORM=linux-amd64

	local LINUXDROID_BUILDGO_FOLDER=$LINUXDROID_COMMON_CACHEDIR/${LINUXDROID_GO_VERSION}
	export GOROOT=$LINUXDROID_BUILDGO_FOLDER
	export PATH=$GOROOT/bin:$PATH

	if [ -d "$LINUXDROID_BUILDGO_FOLDER" ]; then return; fi

	local LINUXDROID_BUILDGO_TAR=$LINUXDROID_COMMON_CACHEDIR/${LINUXDROID_GO_VERSION}.${LINUXDROID_GO_PLATFORM}.tar.gz
	rm -Rf "$LINUXDROID_COMMON_CACHEDIR/go" "$LINUXDROID_BUILDGO_FOLDER"
	linuxdroid_download https://storage.googleapis.com/golang/${LINUXDROID_GO_VERSION}.${LINUXDROID_GO_PLATFORM}.tar.gz \
		"$LINUXDROID_BUILDGO_TAR" \
		1dfe664fa3d8ad714bbd15a36627992effd150ddabd7523931f077b3926d736d

	( cd "$LINUXDROID_COMMON_CACHEDIR"; tar xf "$LINUXDROID_BUILDGO_TAR"; mv go "$LINUXDROID_BUILDGO_FOLDER"; rm "$LINUXDROID_BUILDGO_TAR" )
}

# Utility function for rust-using packages to setup a rust toolchain.
linuxdroid_setup_rust() {
	if [ $LINUXDROID_ARCH = "arm" ]; then
		CARGO_TARGET_NAME=armv7-linux-androideabi
	else
		CARGO_TARGET_NAME=$LINUXDROID_ARCH-linux-android
	fi

	local ENV_NAME=CARGO_TARGET_${CARGO_TARGET_NAME^^}_LINKER
	ENV_NAME=${ENV_NAME//-/_}
	export $ENV_NAME=$CC

	curl https://sh.rustup.rs -sSf > $LINUXDROID_PKG_TMPDIR/rustup.sh
	sh $LINUXDROID_PKG_TMPDIR/rustup.sh -y
	export PATH=$HOME/.cargo/bin:$PATH

	rustup target add $CARGO_TARGET_NAME
}

# Utility function to setup a current ninja build system.
linuxdroid_setup_ninja() {
	local NINJA_VERSION=1.8.2
	local NINJA_FOLDER=$LINUXDROID_COMMON_CACHEDIR/ninja-$NINJA_VERSION
	if [ ! -x "$NINJA_FOLDER/ninja" ]; then
		mkdir -p "$NINJA_FOLDER"
		local NINJA_ZIP_FILE=$LINUXDROID_PKG_TMPDIR/ninja-$NINJA_VERSION.zip
		linuxdroid_download https://github.com/ninja-build/ninja/releases/download/v$NINJA_VERSION/ninja-linux.zip \
			"$NINJA_ZIP_FILE" \
			d2fea9ff33b3ef353161ed906f260d565ca55b8ca0568fa07b1d2cab90a84a07
		unzip "$NINJA_ZIP_FILE" -d "$NINJA_FOLDER"
	fi
	export PATH=$NINJA_FOLDER:$PATH
}

# Utility function to setup a current meson build system.
linuxdroid_setup_meson() {
	linuxdroid_setup_ninja
	local MESON_VERSION=0.48.0
	local MESON_FOLDER=$LINUXDROID_COMMON_CACHEDIR/meson-$MESON_VERSION-v1
	if [ ! -d "$MESON_FOLDER" ]; then
		local MESON_TAR_NAME=meson-$MESON_VERSION.tar.gz
		local MESON_TAR_FILE=$LINUXDROID_PKG_TMPDIR/$MESON_TAR_NAME
		local MESON_TMP_FOLDER=$LINUXDROID_PKG_TMPDIR/meson-$MESON_VERSION
		linuxdroid_download \
			"https://github.com/mesonbuild/meson/releases/download/$MESON_VERSION/meson-$MESON_VERSION.tar.gz" \
			"$MESON_TAR_FILE" \
			982937ba5b380abe13f3a0c4dff944dd19d08b72870e3b039f5037c91f82835f
		tar xf "$MESON_TAR_FILE" -C "$LINUXDROID_PKG_TMPDIR"
		mv "$MESON_TMP_FOLDER" "$MESON_FOLDER"
	fi
	LINUXDROID_MESON="$MESON_FOLDER/meson.py"
	LINUXDROID_MESON_CROSSFILE=$LINUXDROID_COMMON_CACHEDIR/meson-crossfile-$LINUXDROID_ARCH-v2.txt
	if [ ! -f "$LINUXDROID_MESON_CROSSFILE" ]; then
		local MESON_CPU MESON_CPU_FAMILY
		if [ "$LINUXDROID_ARCH" = "arm" ]; then
			MESON_CPU_FAMILY="arm"
			MESON_CPU="armv7"
		elif [ "$LINUXDROID_ARCH" = "i686" ]; then
			MESON_CPU_FAMILY="x86"
			MESON_CPU="i686"
		elif [ "$LINUXDROID_ARCH" = "x86_64" ]; then
			MESON_CPU_FAMILY="x86_64"
			MESON_CPU="x86_64"
		elif [ "$LINUXDROID_ARCH" = "aarch64" ]; then
			MESON_CPU_FAMILY="arm"
			MESON_CPU="aarch64"
		else
			linuxdroid_error_exit "Unsupported arch: $LINUXDROID_ARCH"
		fi

		cat > "$LINUXDROID_MESON_CROSSFILE" <<-HERE
			[binaries]
			ar = '$AR'
			c = '$CC'
			cpp = '$CXX'
			ld = '$LD'
			pkgconfig = '$PKG_CONFIG'
			strip = '$STRIP'
			[properties]
			needs_exe_wrapper = true
			[host_machine]
			cpu_family = '$MESON_CPU_FAMILY'
			cpu = '$MESON_CPU'
			endian = 'little'
			system = 'android'
		HERE
	fi
}

# Utility function to setup a current cmake build system
linuxdroid_setup_cmake() {
	local LINUXDROID_CMAKE_MAJORVESION=3.12
	local LINUXDROID_CMAKE_MINORVERSION=4
	local LINUXDROID_CMAKE_VERSION=$LINUXDROID_CMAKE_MAJORVESION.$LINUXDROID_CMAKE_MINORVERSION
	local LINUXDROID_CMAKE_TARNAME=cmake-${LINUXDROID_CMAKE_VERSION}-Linux-x86_64.tar.gz
	local LINUXDROID_CMAKE_TARFILE=$LINUXDROID_PKG_TMPDIR/$LINUXDROID_CMAKE_TARNAME
	local LINUXDROID_CMAKE_FOLDER=$LINUXDROID_COMMON_CACHEDIR/cmake-$LINUXDROID_CMAKE_VERSION
	if [ ! -d "$LINUXDROID_CMAKE_FOLDER" ]; then
		linuxdroid_download https://cmake.org/files/v$LINUXDROID_CMAKE_MAJORVESION/$LINUXDROID_CMAKE_TARNAME \
		                "$LINUXDROID_CMAKE_TARFILE" \
				486edd6710b5250946b4b199406ccbf8f567ef0e23cfe38f7938b8c78a2ffa5f
		rm -Rf "$LINUXDROID_PKG_TMPDIR/cmake-${LINUXDROID_CMAKE_VERSION}-Linux-x86_64"
		tar xf "$LINUXDROID_CMAKE_TARFILE" -C "$LINUXDROID_PKG_TMPDIR"
		mv "$LINUXDROID_PKG_TMPDIR/cmake-${LINUXDROID_CMAKE_VERSION}-Linux-x86_64" \
		   "$LINUXDROID_CMAKE_FOLDER"
	fi
	export PATH=$LINUXDROID_CMAKE_FOLDER/bin:$PATH
	export CMAKE_INSTALL_ALWAYS=1
}

# First step is to handle command-line arguments. Not to be overridden by packages.
linuxdroid_step_handle_arguments() {
	_show_usage () {
	    echo "Usage: ./build-package.sh [-a ARCH] [-d] [-D] [-f] [-q] [-s] [-o DIR] PACKAGE"
	    echo "Build a package by creating a .deb file in the debs/ folder."
	    echo "  -a The architecture to build for: aarch64(default), arm, i686, x86_64 or all."
	    echo "  -d Build with debug symbols."
	    echo "  -D Build a disabled package in disabled-packages/."
	    echo "  -f Force build even if package has already been built."
	    echo "  -q Quiet build."
	    echo "  -s Skip dependency check."
	    echo "  -o Specify deb directory. Default: debs/."
	    exit 1
	}
	while getopts :a:hdDfqso: option; do
		case "$option" in
		a) LINUXDROID_ARCH="$OPTARG";;
		h) _show_usage;;
		d) export LINUXDROID_DEBUG=true;;
		D) local LINUXDROID_IS_DISABLED=true;;
		f) LINUXDROID_FORCE_BUILD=true;;
		q) export LINUXDROID_QUIET_BUILD=true;;
		s) export LINUXDROID_SKIP_DEPCHECK=true;;
		o) LINUXDROID_DEBDIR="$(realpath -m $OPTARG)";;
		?) linuxdroid_error_exit "./build-package.sh: illegal option -$OPTARG";;
		esac
	done
	shift $((OPTIND-1))

	if [ "$#" -ne 1 ]; then _show_usage; fi
	unset -f _show_usage

	# Handle 'all' arch:
	if [ -n "${LINUXDROID_ARCH+x}" ] && [ "${LINUXDROID_ARCH}" = 'all' ]; then
		for arch in 'aarch64' 'arm' 'i686' 'x86_64'; do
			./build-package.sh ${LINUXDROID_FORCE_BUILD+-f} -a $arch \
				${LINUXDROID_DEBUG+-d} ${LINUXDROID_DEBDIR+-o $LINUXDROID_DEBDIR} "$1"
		done
		exit
	fi

	# Check the package to build:
	LINUXDROID_PKG_NAME=$(basename "$1")
	export LINUXDROID_SCRIPTDIR
	LINUXDROID_SCRIPTDIR=$(cd "$(dirname "$0")"; pwd)
	if [[ $1 == *"/"* ]]; then
		# Path to directory which may be outside this repo:
		if [ ! -d "$1" ]; then linuxdroid_error_exit "'$1' seems to be a path but is not a directory"; fi
		export LINUXDROID_PKG_BUILDER_DIR
		LINUXDROID_PKG_BUILDER_DIR=$(realpath "$1")
	else
		# Package name:
		if [ -n "${LINUXDROID_IS_DISABLED=""}" ]; then
			export LINUXDROID_PKG_BUILDER_DIR=$LINUXDROID_SCRIPTDIR/disabled-packages/$LINUXDROID_PKG_NAME
		else
			export LINUXDROID_PKG_BUILDER_DIR=$LINUXDROID_SCRIPTDIR/packages/$LINUXDROID_PKG_NAME
		fi
	fi
	LINUXDROID_PKG_BUILDER_SCRIPT=$LINUXDROID_PKG_BUILDER_DIR/build.sh
	if test ! -f "$LINUXDROID_PKG_BUILDER_SCRIPT"; then
		linuxdroid_error_exit "No build.sh script at package dir $LINUXDROID_PKG_BUILDER_DIR!"
	fi
}

# Setup variables used by the build. Not to be overridden by packages.
linuxdroid_step_setup_variables() {
	# shellcheck source=scripts/properties.sh
	. "$LINUXDROID_SCRIPTDIR/scripts/properties.sh"
	: "${LINUXDROID_MAKE_PROCESSES:="$(nproc)"}"
	: "${LINUXDROID_TOPDIR:="$HOME/.linuxdroid-build"}"
	: "${LINUXDROID_ARCH:="aarch64"}" # arm, aarch64, i686 or x86_64.
	: "${LINUXDROID_PREFIX:="/data/data/com.linuxdroid/files/usr"}"
	: "${LINUXDROID_ANDROID_HOME:="/data/data/com.linuxdroid/files/home"}"
	: "${LINUXDROID_DEBUG:=""}"
	: "${LINUXDROID_PKG_API_LEVEL:="21"}"
	: "${LINUXDROID_DEBDIR:="${LINUXDROID_SCRIPTDIR}/debs"}"

	if [ "x86_64" = "$LINUXDROID_ARCH" ] || [ "aarch64" = "$LINUXDROID_ARCH" ]; then
		LINUXDROID_ARCH_BITS=64
	else
		LINUXDROID_ARCH_BITS=32
	fi

	LINUXDROID_HOST_PLATFORM="${LINUXDROID_ARCH}-linux-android"
	if [ "$LINUXDROID_ARCH" = "arm" ]; then LINUXDROID_HOST_PLATFORM="${LINUXDROID_HOST_PLATFORM}eabi"; fi

	if [ ! -d "$NDK" ]; then
		linuxdroid_error_exit 'NDK not pointing at a directory!'
	fi
	if ! grep -s -q "Pkg.Revision = $LINUXDROID_NDK_VERSION" "$NDK/source.properties"; then
		linuxdroid_error_exit "Wrong NDK version - we need $LINUXDROID_NDK_VERSION"
	fi

	# The build tuple that may be given to --build configure flag:
	LINUXDROID_BUILD_TUPLE=$(sh "$LINUXDROID_SCRIPTDIR/scripts/config.guess")

	# We do not put all of build-tools/$LINUXDROID_ANDROID_BUILD_TOOLS_VERSION/ into PATH
	# to avoid stuff like arm-linux-androideabi-ld there to conflict with ones from
	# the standalone toolchain.
	LINUXDROID_D8=$ANDROID_HOME/build-tools/$LINUXDROID_ANDROID_BUILD_TOOLS_VERSION/d8

	LINUXDROID_COMMON_CACHEDIR="$LINUXDROID_TOPDIR/_cache"
	LINUXDROID_ELF_CLEANER=$LINUXDROID_COMMON_CACHEDIR/linuxdroid-elf-cleaner

	export prefix=${LINUXDROID_PREFIX}
	export PREFIX=${LINUXDROID_PREFIX}

	LINUXDROID_PKG_BUILDDIR=$LINUXDROID_TOPDIR/$LINUXDROID_PKG_NAME/build
	LINUXDROID_PKG_CACHEDIR=$LINUXDROID_TOPDIR/$LINUXDROID_PKG_NAME/cache
	LINUXDROID_PKG_MASSAGEDIR=$LINUXDROID_TOPDIR/$LINUXDROID_PKG_NAME/massage
	LINUXDROID_PKG_PACKAGEDIR=$LINUXDROID_TOPDIR/$LINUXDROID_PKG_NAME/package
	LINUXDROID_PKG_SRCDIR=$LINUXDROID_TOPDIR/$LINUXDROID_PKG_NAME/src
	LINUXDROID_PKG_SHA256=""
	LINUXDROID_PKG_TMPDIR=$LINUXDROID_TOPDIR/$LINUXDROID_PKG_NAME/tmp
	LINUXDROID_PKG_HOSTBUILD_DIR=$LINUXDROID_TOPDIR/$LINUXDROID_PKG_NAME/host-build
	LINUXDROID_PKG_PLATFORM_INDEPENDENT=""
	LINUXDROID_PKG_NO_DEVELSPLIT=""
	LINUXDROID_PKG_REVISION="0" # http://www.debian.org/doc/debian-policy/ch-controlfields.html#s-f-Version
	LINUXDROID_PKG_EXTRA_CONFIGURE_ARGS=""
	LINUXDROID_PKG_EXTRA_HOSTBUILD_CONFIGURE_ARGS=""
	LINUXDROID_PKG_EXTRA_MAKE_ARGS=""
	LINUXDROID_PKG_BUILD_IN_SRC=""
	LINUXDROID_PKG_RM_AFTER_INSTALL=""
	LINUXDROID_PKG_BREAKS="" # https://www.debian.org/doc/debian-policy/ch-relationships.html#s-binarydeps
	LINUXDROID_PKG_DEPENDS=""
	LINUXDROID_PKG_BUILD_DEPENDS=""
	LINUXDROID_PKG_HOMEPAGE=""
	LINUXDROID_PKG_DESCRIPTION="FIXME:Add description"
	LINUXDROID_PKG_KEEP_STATIC_LIBRARIES="false"
	LINUXDROID_PKG_ESSENTIAL=""
	LINUXDROID_PKG_CONFLICTS="" # https://www.debian.org/doc/debian-policy/ch-relationships.html#s-conflicts
	LINUXDROID_PKG_RECOMMENDS="" # https://www.debian.org/doc/debian-policy/ch-relationships.html#s-binarydeps
	LINUXDROID_PKG_SUGGESTS=""
	LINUXDROID_PKG_REPLACES=""
	LINUXDROID_PKG_PROVIDES="" #https://www.debian.org/doc/debian-policy/#virtual-packages-provides
	LINUXDROID_PKG_CONFFILES=""
	LINUXDROID_PKG_INCLUDE_IN_DEVPACKAGE=""
	LINUXDROID_PKG_DEVPACKAGE_DEPENDS=""
	# Set if a host build should be done in LINUXDROID_PKG_HOSTBUILD_DIR:
	LINUXDROID_PKG_HOSTBUILD=""
	LINUXDROID_PKG_MAINTAINER="Fredrik Fornwall @fornwall"
	LINUXDROID_PKG_FORCE_CMAKE=no # if the package has autotools as well as cmake, then set this to prefer cmake
	LINUXDROID_CMAKE_BUILD=Ninja # Which cmake generator to use
	LINUXDROID_PKG_HAS_DEBUG=yes # set to no if debug build doesn't exist or doesn't work, for example for python based packages

	unset CFLAGS CPPFLAGS LDFLAGS CXXFLAGS
}

# Save away and restore build setups which may change between builds.
linuxdroid_step_handle_buildarch() {
	# If $LINUXDROID_PREFIX already exists, it may have been built for a different arch
	local LINUXDROID_ARCH_FILE=/data/LINUXDROID_ARCH
	if [ -f "${LINUXDROID_ARCH_FILE}" ]; then
		local LINUXDROID_PREVIOUS_ARCH
		LINUXDROID_PREVIOUS_ARCH=$(cat $LINUXDROID_ARCH_FILE)
		if [ "$LINUXDROID_PREVIOUS_ARCH" != "$LINUXDROID_ARCH" ]; then
			local LINUXDROID_DATA_BACKUPDIRS=$LINUXDROID_TOPDIR/_databackups
			mkdir -p "$LINUXDROID_DATA_BACKUPDIRS"
			local LINUXDROID_DATA_PREVIOUS_BACKUPDIR=$LINUXDROID_DATA_BACKUPDIRS/$LINUXDROID_PREVIOUS_ARCH
			local LINUXDROID_DATA_CURRENT_BACKUPDIR=$LINUXDROID_DATA_BACKUPDIRS/$LINUXDROID_ARCH
			# Save current /data (removing old backup if any)
			if test -e "$LINUXDROID_DATA_PREVIOUS_BACKUPDIR"; then
				linuxdroid_error_exit "Directory already exists"
			fi
			if [ -d /data/data ]; then
				mv /data/data "$LINUXDROID_DATA_PREVIOUS_BACKUPDIR"
			fi
			# Restore new one (if any)
			if [ -d "$LINUXDROID_DATA_CURRENT_BACKUPDIR" ]; then
				mv "$LINUXDROID_DATA_CURRENT_BACKUPDIR" /data/data
			fi
		fi
	fi

	# Keep track of current arch we are building for.
	echo "$LINUXDROID_ARCH" > $LINUXDROID_ARCH_FILE
}

# Source the package build script and start building. No to be overridden by packages.
linuxdroid_step_start_build() {
	# shellcheck source=/dev/null
	source "$LINUXDROID_PKG_BUILDER_SCRIPT"

	LINUXDROID_STANDALONE_TOOLCHAIN="$LINUXDROID_COMMON_CACHEDIR/${LINUXDROID_NDK_VERSION}-${LINUXDROID_ARCH}-${LINUXDROID_PKG_API_LEVEL}"
	# Bump the below version if a change is made in toolchain setup to ensure
	# that everyone gets an updated toolchain:
	LINUXDROID_STANDALONE_TOOLCHAIN+="-v1"

	if [ -n "${LINUXDROID_PKG_BLACKLISTED_ARCHES:=""}" ] && [ "$LINUXDROID_PKG_BLACKLISTED_ARCHES" != "${LINUXDROID_PKG_BLACKLISTED_ARCHES/$LINUXDROID_ARCH/}" ]; then
		echo "Skipping building $LINUXDROID_PKG_NAME for arch $LINUXDROID_ARCH"
		exit 0
	fi

	if [ -z "${LINUXDROID_SKIP_DEPCHECK:=""}" ]; then
		local p LINUXDROID_ALL_DEPS
		LINUXDROID_ALL_DEPS=$(./scripts/buildorder.py "$LINUXDROID_PKG_BUILDER_DIR")
		for p in $LINUXDROID_ALL_DEPS; do
			echo "Building dependency $p if necessary..."
			# Built dependencies are put in the default LINUXDROID_DEBDIR instead of the specified one
			./build-package.sh -a $LINUXDROID_ARCH -s "$p"
		done
	fi

	LINUXDROID_PKG_FULLVERSION=$LINUXDROID_PKG_VERSION
	if [ "$LINUXDROID_PKG_REVISION" != "0" ] || [ "$LINUXDROID_PKG_FULLVERSION" != "${LINUXDROID_PKG_FULLVERSION/-/}" ]; then
		# "0" is the default revision, so only include it if the upstream versions contains "-" itself
		LINUXDROID_PKG_FULLVERSION+="-$LINUXDROID_PKG_REVISION"
	fi

	if [ "$LINUXDROID_DEBUG" == "true" ]; then
		if [ "$LINUXDROID_PKG_HAS_DEBUG" == "yes" ]; then
			DEBUG="-dbg"
		else
			echo "Skipping building debug build for $LINUXDROID_PKG_NAME"
			exit 0
		fi
	else
		DEBUG=""
	fi

	if [ -z "$LINUXDROID_DEBUG" ] &&
	   [ -z "${LINUXDROID_FORCE_BUILD+x}" ] &&
	   [ -e "/data/data/.built-packages/$LINUXDROID_PKG_NAME" ]; then
		if [ "$(cat "/data/data/.built-packages/$LINUXDROID_PKG_NAME")" = "$LINUXDROID_PKG_FULLVERSION" ]; then
			echo "$LINUXDROID_PKG_NAME@$LINUXDROID_PKG_FULLVERSION built - skipping (rm /data/data/.built-packages/$LINUXDROID_PKG_NAME to force rebuild)"
			exit 0
		fi
	fi

	# Cleanup old state:
	rm -Rf "$LINUXDROID_PKG_BUILDDIR" \
		"$LINUXDROID_PKG_PACKAGEDIR" \
		"$LINUXDROID_PKG_SRCDIR" \
		"$LINUXDROID_PKG_TMPDIR" \
		"$LINUXDROID_PKG_MASSAGEDIR"

	# Ensure folders present (but not $LINUXDROID_PKG_SRCDIR, it will be created in build)
	mkdir -p "$LINUXDROID_COMMON_CACHEDIR" \
		"$LINUXDROID_DEBDIR" \
		 "$LINUXDROID_PKG_BUILDDIR" \
		 "$LINUXDROID_PKG_PACKAGEDIR" \
		 "$LINUXDROID_PKG_TMPDIR" \
		 "$LINUXDROID_PKG_CACHEDIR" \
		 "$LINUXDROID_PKG_MASSAGEDIR" \
		 $LINUXDROID_PREFIX/{bin,etc,lib,libexec,share,tmp,include}

	# Make $LINUXDROID_PREFIX/bin/sh executable on the builder, so that build
	# scripts can assume that it works on both builder and host later on:
	ln -f -s /bin/sh "$LINUXDROID_PREFIX/bin/sh"

	local LINUXDROID_ELF_CLEANER_SRC=$LINUXDROID_COMMON_CACHEDIR/linuxdroid-elf-cleaner.cpp
	local LINUXDROID_ELF_CLEANER_VERSION
	LINUXDROID_ELF_CLEANER_VERSION=$(bash -c ". $LINUXDROID_SCRIPTDIR/packages/linuxdroid-elf-cleaner/build.sh; echo \$LINUXDROID_PKG_VERSION")
	linuxdroid_download \
		"https://raw.githubusercontent.com/linuxdroid/linuxdroid-elf-cleaner/v$LINUXDROID_ELF_CLEANER_VERSION/linuxdroid-elf-cleaner.cpp" \
		"$LINUXDROID_ELF_CLEANER_SRC" \
		62c3cf9813756a1b262108fbc39684c5cfd3f9a69b376276bb1ac6af138f5fa2
	if [ "$LINUXDROID_ELF_CLEANER_SRC" -nt "$LINUXDROID_ELF_CLEANER" ]; then
		g++ -std=c++11 -Wall -Wextra -pedantic -Os "$LINUXDROID_ELF_CLEANER_SRC" -o "$LINUXDROID_ELF_CLEANER"
	fi

	if [ -n "$LINUXDROID_PKG_BUILD_IN_SRC" ]; then
		echo "Building in src due to LINUXDROID_PKG_BUILD_IN_SRC being set" > "$LINUXDROID_PKG_BUILDDIR/BUILDING_IN_SRC.txt"
		LINUXDROID_PKG_BUILDDIR=$LINUXDROID_PKG_SRCDIR
	fi

	echo "linuxdroid - building $LINUXDROID_PKG_NAME for arch $LINUXDROID_ARCH..."
	test -t 1 && printf "\033]0;%s...\007" "$LINUXDROID_PKG_NAME"

	# Avoid exporting PKG_CONFIG_LIBDIR until after linuxdroid_step_host_build.
	export LINUXDROID_PKG_CONFIG_LIBDIR=$LINUXDROID_PREFIX/lib/pkgconfig
	# Add a pkg-config file for the system zlib.
	mkdir -p "$LINUXDROID_PKG_CONFIG_LIBDIR"
	cat > "$LINUXDROID_PKG_CONFIG_LIBDIR/zlib.pc" <<-HERE
		Name: zlib
		Description: zlib compression library
		Version: 1.2.8
		Requires:
		Libs: -lz
	HERE

	# Keep track of when build started so we can see what files have been created.
	# We start by sleeping so that any generated files above (such as zlib.pc) get
	# an older timestamp than the LINUXDROID_BUILD_TS_FILE.
	sleep 1
	LINUXDROID_BUILD_TS_FILE=$LINUXDROID_PKG_TMPDIR/timestamp_$LINUXDROID_PKG_NAME
	touch "$LINUXDROID_BUILD_TS_FILE"
}

# Run just after sourcing $LINUXDROID_PKG_BUILDER_SCRIPT. May be overridden by packages.
linuxdroid_step_extract_package() {
	if [ -z "${LINUXDROID_PKG_SRCURL:=""}" ] || [ -n "${LINUXDROID_PKG_SKIP_SRC_EXTRACT:=""}" ]; then
		mkdir -p "$LINUXDROID_PKG_SRCDIR"
		return
	fi
	cd "$LINUXDROID_PKG_TMPDIR"
	local PKG_SRCURL=(${LINUXDROID_PKG_SRCURL[@]})
	local PKG_SHA256=(${LINUXDROID_PKG_SHA256[@]})
	if  [ ! ${#PKG_SRCURL[@]} == ${#PKG_SHA256[@]} ] && [ ! ${#PKG_SHA256[@]} == 0 ]; then
		linuxdroid_error_exit "Error: length of LINUXDROID_PKG_SRCURL isn't equal to length of LINUXDROID_PKG_SHA256."
	fi
	# STRIP=1 extracts archives straight into LINUXDROID_PKG_SRCDIR while STRIP=0 puts them in subfolders. zip has same behaviour per default
	# If this isn't desired then this can be fixed in linuxdroid_step_post_extract_package.
	local STRIP=1
	for i in $(seq 0 $(( ${#PKG_SRCURL[@]}-1 ))); do
		test "$i" -gt 0 && STRIP=0
		local filename
		filename=$(basename "${PKG_SRCURL[$i]}")
		local file="$LINUXDROID_PKG_CACHEDIR/$filename"
		# Allow LINUXDROID_PKG_SHA256 to be empty:
		set +u
		linuxdroid_download "${PKG_SRCURL[$i]}" "$file" "${PKG_SHA256[$i]}"
		set -u

		local folder
		set +o pipefail
		if [ "${file##*.}" = zip ]; then
			folder=`unzip -qql "$file" | head -n1 | tr -s ' ' | cut -d' ' -f5-`
			rm -Rf $folder
			unzip -q "$file"
			mv $folder "$LINUXDROID_PKG_SRCDIR"
		else
			mkdir -p "$LINUXDROID_PKG_SRCDIR"
			tar xf "$file" -C "$LINUXDROID_PKG_SRCDIR" --strip-components=$STRIP
		fi
		set -o pipefail
	done
}

# Hook for packages to act just after the package has been extracted.
# Invoked in $LINUXDROID_PKG_SRCDIR.
linuxdroid_step_post_extract_package() {
        return
}

# Optional host build. Not to be overridden by packages.
linuxdroid_step_handle_hostbuild() {
	if [ "x$LINUXDROID_PKG_HOSTBUILD" = "x" ]; then return; fi

	cd "$LINUXDROID_PKG_SRCDIR"
	for patch in $LINUXDROID_PKG_BUILDER_DIR/*.patch.beforehostbuild; do
		test -f "$patch" && sed "s%\@LINUXDROID_PREFIX\@%${LINUXDROID_PREFIX}%g" "$patch" | patch --silent -p1
	done

	local LINUXDROID_HOSTBUILD_MARKER="$LINUXDROID_PKG_HOSTBUILD_DIR/LINUXDROID_BUILT_FOR_$LINUXDROID_PKG_VERSION"
	if [ ! -f "$LINUXDROID_HOSTBUILD_MARKER" ]; then
		rm -Rf "$LINUXDROID_PKG_HOSTBUILD_DIR"
		mkdir -p "$LINUXDROID_PKG_HOSTBUILD_DIR"
		cd "$LINUXDROID_PKG_HOSTBUILD_DIR"
		linuxdroid_step_host_build
		touch "$LINUXDROID_HOSTBUILD_MARKER"
	fi
}

# Perform a host build. Will be called in $LINUXDROID_PKG_HOSTBUILD_DIR.
# After linuxdroid_step_post_extract_package() and before linuxdroid_step_patch_package()
linuxdroid_step_host_build() {
	"$LINUXDROID_PKG_SRCDIR/configure" ${LINUXDROID_PKG_EXTRA_HOSTBUILD_CONFIGURE_ARGS}
	make -j "$LINUXDROID_MAKE_PROCESSES"
}

# Setup a standalone Android NDK toolchain. Not to be overridden by packages.
linuxdroid_step_setup_toolchain() {
	# We put this after system PATH to avoid picking up toolchain stripped python
	export PATH=$PATH:$LINUXDROID_STANDALONE_TOOLCHAIN/bin

	export CFLAGS=""
	export LDFLAGS="-L${LINUXDROID_PREFIX}/lib"

	export AS=${LINUXDROID_HOST_PLATFORM}-clang
	export CC=$LINUXDROID_HOST_PLATFORM-clang
	export CXX=$LINUXDROID_HOST_PLATFORM-clang++

	export AR=$LINUXDROID_HOST_PLATFORM-ar
	export CPP=${LINUXDROID_HOST_PLATFORM}-cpp
	export CC_FOR_BUILD=gcc
	export LD=$LINUXDROID_HOST_PLATFORM-ld
	export OBJDUMP=$LINUXDROID_HOST_PLATFORM-objdump
	# Setup pkg-config for cross-compiling:
	export PKG_CONFIG=$LINUXDROID_STANDALONE_TOOLCHAIN/bin/${LINUXDROID_HOST_PLATFORM}-pkg-config
	export RANLIB=$LINUXDROID_HOST_PLATFORM-ranlib
	export READELF=$LINUXDROID_HOST_PLATFORM-readelf
	export STRIP=$LINUXDROID_HOST_PLATFORM-strip

	# Android 7 started to support DT_RUNPATH (but not DT_RPATH), so we may want
	# LDFLAGS+="-Wl,-rpath=$LINUXDROID_PREFIX/lib -Wl,--enable-new-dtags"
	# and no longer remove DT_RUNPATH in linuxdroid-elf-cleaner.

	if [ "$LINUXDROID_ARCH" = "arm" ]; then
		# https://developer.android.com/ndk/guides/standalone_toolchain.html#abi_compatibility:
		# "We recommend using the -mthumb compiler flag to force the generation of 16-bit Thumb-2 instructions".
		# With r13 of the ndk ruby 2.4.0 segfaults when built on arm with clang without -mthumb.
		CFLAGS+=" -march=armv7-a -mfpu=neon -mfloat-abi=softfp -mthumb"
		LDFLAGS+=" -march=armv7-a"
	elif [ "$LINUXDROID_ARCH" = "i686" ]; then
		# From $NDK/docs/CPU-ARCH-ABIS.html:
		CFLAGS+=" -march=i686 -msse3 -mstackrealign -mfpmath=sse"
	elif [ "$LINUXDROID_ARCH" = "aarch64" ]; then
		:
	elif [ "$LINUXDROID_ARCH" = "x86_64" ]; then
		:
	else
		linuxdroid_error_exit "Invalid arch '$LINUXDROID_ARCH' - support arches are 'arm', 'i686', 'aarch64', 'x86_64'"
	fi

	if [ -n "$LINUXDROID_DEBUG" ]; then
		CFLAGS+=" -g3 -O1 -fstack-protector --param ssp-buffer-size=4 -D_FORTIFY_SOURCE=2"
	else
		if [ $LINUXDROID_ARCH = arm ]; then
			CFLAGS+=" -Os"
		else
			CFLAGS+=" -Oz"
		fi
	fi

	export CXXFLAGS="$CFLAGS"
	export CPPFLAGS="-I${LINUXDROID_PREFIX}/include"

	if [ "$LINUXDROID_PKG_DEPENDS" != "${LINUXDROID_PKG_DEPENDS/libandroid-support/}" ]; then
		# If using the android support library, link to it and include its headers as system headers:
		CPPFLAGS+=" -isystem $LINUXDROID_PREFIX/include/libandroid-support"
		LDFLAGS+=" -landroid-support"
	fi

	export ac_cv_func_getpwent=no
	export ac_cv_func_getpwnam=no
	export ac_cv_func_getpwuid=no
	export ac_cv_func_sigsetmask=no
	export ac_cv_c_bigendian=no

	if [ ! -d $LINUXDROID_STANDALONE_TOOLCHAIN ]; then
		# Do not put toolchain in place until we are done with setup, to avoid having a half setup
		# toolchain left in place if something goes wrong (or process is just aborted):
		local _LINUXDROID_TOOLCHAIN_TMPDIR=${LINUXDROID_STANDALONE_TOOLCHAIN}-tmp
		rm -Rf $_LINUXDROID_TOOLCHAIN_TMPDIR

		local _NDK_ARCHNAME=$LINUXDROID_ARCH
		if [ "$LINUXDROID_ARCH" = "aarch64" ]; then
			_NDK_ARCHNAME=arm64
		elif [ "$LINUXDROID_ARCH" = "i686" ]; then
			_NDK_ARCHNAME=x86
		fi

		"$NDK/build/tools/make_standalone_toolchain.py" \
			--api "$LINUXDROID_PKG_API_LEVEL" \
			--arch $_NDK_ARCHNAME \
			--stl=libc++ \
			--install-dir $_LINUXDROID_TOOLCHAIN_TMPDIR

		# Remove android-support header wrapping not needed on android-21:
		rm -Rf $_LINUXDROID_TOOLCHAIN_TMPDIR/sysroot/usr/local

		if [ "$LINUXDROID_ARCH" = "aarch64" ]; then
			# Use gold by default to work around https://github.com/android-ndk/ndk/issues/148
			cp $_LINUXDROID_TOOLCHAIN_TMPDIR/bin/aarch64-linux-android-ld.gold \
			    $_LINUXDROID_TOOLCHAIN_TMPDIR/bin/aarch64-linux-android-ld
			cp $_LINUXDROID_TOOLCHAIN_TMPDIR/aarch64-linux-android/bin/ld.gold \
			    $_LINUXDROID_TOOLCHAIN_TMPDIR/aarch64-linux-android/bin/ld
		fi

		if [ "$LINUXDROID_ARCH" = "arm" ]; then
			# Linker wrapper script to add '--exclude-libs libgcc.a', see
			# https://github.com/android-ndk/ndk/issues/379
			# https://android-review.googlesource.com/#/c/389852/
			local linker
			for linker in ld ld.bfd ld.gold; do
				local wrap_linker=$_LINUXDROID_TOOLCHAIN_TMPDIR/$LINUXDROID_HOST_PLATFORM/bin/$linker
				local real_linker=$_LINUXDROID_TOOLCHAIN_TMPDIR/$LINUXDROID_HOST_PLATFORM/bin/$linker.real
				cp $wrap_linker $real_linker
				echo '#!/bin/bash' > $wrap_linker
				echo -n '`dirname $0`/' >> $wrap_linker
				echo -n $linker.real >> $wrap_linker
				echo ' --exclude-libs libgcc.a "$@"' >> $wrap_linker
			done
		fi

		# Setup the cpp preprocessor:
		cp $_LINUXDROID_TOOLCHAIN_TMPDIR/bin/$LINUXDROID_HOST_PLATFORM-clang \
		   $_LINUXDROID_TOOLCHAIN_TMPDIR/bin/$LINUXDROID_HOST_PLATFORM-cpp
		sed -i 's/clang70/clang70 -E/' \
		   $_LINUXDROID_TOOLCHAIN_TMPDIR/bin/$LINUXDROID_HOST_PLATFORM-cpp

		cd $_LINUXDROID_TOOLCHAIN_TMPDIR/sysroot

		for f in $LINUXDROID_SCRIPTDIR/ndk-patches/*.patch; do
			sed "s%\@LINUXDROID_PREFIX\@%${LINUXDROID_PREFIX}%g" "$f" | \
				sed "s%\@LINUXDROID_HOME\@%${LINUXDROID_ANDROID_HOME}%g" | \
				patch --silent -p1;
		done
		# elf.h: Taken from glibc since the elf.h in the NDK is lacking.
		# ifaddrs.h: Added in android-24 unified headers, use a inline implementation for now.
		cp "$LINUXDROID_SCRIPTDIR"/ndk-patches/{ifaddrs.h,libintl.h} usr/include

		# Remove <sys/shm.h> from the NDK in favour of that from the libandroid-shmem.
		# Remove <sys/sem.h> as it doesn't work for non-root.
		# Remove <iconv.h> as we currently provide it from libandroid-support.
		# Remove <glob.h> as we currently provide it from libandroid-glob.
		# Remove <spawn.h> as it's only for future (later than android-27).
		rm usr/include/sys/{shm.h,sem.h} usr/include/{iconv.h,glob.h,spawn.h}

		sed -i "s/define __ANDROID_API__ __ANDROID_API_FUTURE__/define __ANDROID_API__ $LINUXDROID_PKG_API_LEVEL/" \
			usr/include/android/api-level.h

		local _LIBDIR=usr/lib
		if [ $LINUXDROID_ARCH = x86_64 ]; then _LIBDIR+=64; fi
		$LINUXDROID_ELF_CLEANER $_LIBDIR/*.so

		# zlib is really version 1.2.8 in the Android platform (at least
		# starting from Android 5), not older as the NDK headers claim.
		for file in zconf.h zlib.h; do
			curl -o usr/include/$file \
			        https://raw.githubusercontent.com/madler/zlib/v1.2.8/$file
		done
		unset file
		cd $_LINUXDROID_TOOLCHAIN_TMPDIR/include/c++/4.9.x
                sed "s%\@LINUXDROID_HOST_PLATFORM\@%${LINUXDROID_HOST_PLATFORM}%g" $LINUXDROID_SCRIPTDIR/ndk-patches/*.cpppatch | patch -p1
		# Fix relative path in gcc/g++ script:
		sed -i "s%\`dirname \$0\`/../../../../%$NDK/toolchains/%g" $_LINUXDROID_TOOLCHAIN_TMPDIR/bin/${LINUXDROID_HOST_PLATFORM}-gcc
		sed -i "s%\`dirname \$0\`/../../../../%$NDK/toolchains/%g" $_LINUXDROID_TOOLCHAIN_TMPDIR/bin/${LINUXDROID_HOST_PLATFORM}-g++
		mv $_LINUXDROID_TOOLCHAIN_TMPDIR $LINUXDROID_STANDALONE_TOOLCHAIN
	fi

	local _STL_LIBFILE_NAME=libc++_shared.so
	if [ ! -f $LINUXDROID_PREFIX/lib/libstdc++.so ]; then
		# Setup libc++_shared.so in $PREFIX/lib and libstdc++.so as a link to it,
		# so that other C++ using packages links to it instead of the default android
		# C++ library which does not support exceptions or STL:
		# https://developer.android.com/ndk/guides/cpp-support.html
		# We do however want to avoid installing this, to avoid problems where e.g.
		# libm.so on some i686 devices links against libstdc++.so.
		# The libc++_shared.so library will be packaged in the libc++ package
		# which is part of the base Linuxdroid installation.
		mkdir -p "$LINUXDROID_PREFIX/lib"
		cd "$LINUXDROID_PREFIX/lib"

		local _STL_LIBFILE=
		if [ "$LINUXDROID_ARCH" = arm ]; then
			local _STL_LIBFILE=$LINUXDROID_STANDALONE_TOOLCHAIN/${LINUXDROID_HOST_PLATFORM}/lib/armv7-a/$_STL_LIBFILE_NAME
		elif [ "$LINUXDROID_ARCH" = x86_64 ]; then
			local _STL_LIBFILE=$LINUXDROID_STANDALONE_TOOLCHAIN/${LINUXDROID_HOST_PLATFORM}/lib64/$_STL_LIBFILE_NAME
		else
			local _STL_LIBFILE=$LINUXDROID_STANDALONE_TOOLCHAIN/${LINUXDROID_HOST_PLATFORM}/lib/$_STL_LIBFILE_NAME
		fi

		cp "$_STL_LIBFILE" .
		$STRIP --strip-unneeded $_STL_LIBFILE_NAME
		$LINUXDROID_ELF_CLEANER $_STL_LIBFILE_NAME
		if [ $LINUXDROID_ARCH = "arm" ]; then
			# Use a linker script to get libunwind.a.
			echo 'INPUT(-lunwind -lc++_shared)' > libstdc++.so
		else
			ln -f $_STL_LIBFILE_NAME libstdc++.so
		fi
	fi

	export PKG_CONFIG_LIBDIR="$LINUXDROID_PKG_CONFIG_LIBDIR"
	# Create a pkg-config wrapper. We use path to host pkg-config to
	# avoid picking up a cross-compiled pkg-config later on.
	local _HOST_PKGCONFIG
	_HOST_PKGCONFIG=$(which pkg-config)
	mkdir -p $LINUXDROID_STANDALONE_TOOLCHAIN/bin "$PKG_CONFIG_LIBDIR"
	cat > "$PKG_CONFIG" <<-HERE
		#!/bin/sh
		export PKG_CONFIG_DIR=
		export PKG_CONFIG_LIBDIR=$PKG_CONFIG_LIBDIR
		exec $_HOST_PKGCONFIG "\$@"
	HERE
	chmod +x "$PKG_CONFIG"
}

# Apply all *.patch files for the package. Not to be overridden by packages.
linuxdroid_step_patch_package() {
	cd "$LINUXDROID_PKG_SRCDIR"
	local DEBUG_PATCHES=""
	if [ "$LINUXDROID_DEBUG" == "true" ] && [ -f $LINUXDROID_PKG_BUILDER_DIR/*.patch.debug ] ; then
		DEBUG_PATCHES="$(ls $LINUXDROID_PKG_BUILDER_DIR/*.patch.debug)"
	fi
	# Suffix patch with ".patch32" or ".patch64" to only apply for these bitnesses:
	shopt -s nullglob
	for patch in $LINUXDROID_PKG_BUILDER_DIR/*.patch{$LINUXDROID_ARCH_BITS,} $DEBUG_PATCHES; do
		test -f "$patch" && sed "s%\@LINUXDROID_PREFIX\@%${LINUXDROID_PREFIX}%g" "$patch" | \
			sed "s%\@LINUXDROID_HOME\@%${LINUXDROID_ANDROID_HOME}%g" | \
			patch --silent -p1
	done
	shopt -u nullglob
}

# Replace autotools build-aux/config.{sub,guess} with ours to add android targets.
linuxdroid_step_replace_guess_scripts () {
	cd "$LINUXDROID_PKG_SRCDIR"
	find . -name config.sub -exec chmod u+w '{}' \; -exec cp "$LINUXDROID_SCRIPTDIR/scripts/config.sub" '{}' \;
	find . -name config.guess -exec chmod u+w '{}' \; -exec cp "$LINUXDROID_SCRIPTDIR/scripts/config.guess" '{}' \;
}

# For package scripts to override. Called in $LINUXDROID_PKG_BUILDDIR.
linuxdroid_step_pre_configure() {
	return
}

linuxdroid_step_configure_autotools () {
	if [ ! -e "$LINUXDROID_PKG_SRCDIR/configure" ]; then return; fi

	local DISABLE_STATIC="--disable-static"
	if [ "$LINUXDROID_PKG_EXTRA_CONFIGURE_ARGS" != "${LINUXDROID_PKG_EXTRA_CONFIGURE_ARGS/--enable-static/}" ]; then
		# Do not --disable-static if package explicitly enables it (e.g. gdb needs enable-static to build)
		DISABLE_STATIC=""
	fi

	local DISABLE_NLS="--disable-nls"
	if [ "$LINUXDROID_PKG_EXTRA_CONFIGURE_ARGS" != "${LINUXDROID_PKG_EXTRA_CONFIGURE_ARGS/--enable-nls/}" ]; then
		# Do not --disable-nls if package explicitly enables it (for gettext itself)
		DISABLE_NLS=""
	fi

	local ENABLE_SHARED="--enable-shared"
	if [ "$LINUXDROID_PKG_EXTRA_CONFIGURE_ARGS" != "${LINUXDROID_PKG_EXTRA_CONFIGURE_ARGS/--disable-shared/}" ]; then
		ENABLE_SHARED=""
	fi

	local HOST_FLAG="--host=$LINUXDROID_HOST_PLATFORM"
	if [ "$LINUXDROID_PKG_EXTRA_CONFIGURE_ARGS" != "${LINUXDROID_PKG_EXTRA_CONFIGURE_ARGS/--host=/}" ]; then
		HOST_FLAG=""
	fi

	local LIBEXEC_FLAG="--libexecdir=$LINUXDROID_PREFIX/libexec"
	if [ "$LINUXDROID_PKG_EXTRA_CONFIGURE_ARGS" != "${LINUXDROID_PKG_EXTRA_CONFIGURE_ARGS/--libexecdir=/}" ]; then
		LIBEXEC_FLAG=""
	fi

	local QUIET_BUILD=
	if [ ! -z ${LINUXDROID_QUIET_BUILD+x} ]; then
		QUIET_BUILD="--enable-silent-rules --silent --quiet"
	fi

	# Some packages provides a $PKG-config script which some configure scripts pickup instead of pkg-config:
	mkdir "$LINUXDROID_PKG_TMPDIR/config-scripts"
	for f in $LINUXDROID_PREFIX/bin/*config; do
		test -f "$f" && cp "$f" "$LINUXDROID_PKG_TMPDIR/config-scripts"
	done
	export PATH=$LINUXDROID_PKG_TMPDIR/config-scripts:$PATH

	# Avoid gnulib wrapping of functions when cross compiling. See
	# http://wiki.osdev.org/Cross-Porting_Software#Gnulib
	# https://gitlab.com/sortix/sortix/wikis/Gnulib
	# https://github.com/linuxdroid/linuxdroid-packages/issues/76
	local AVOID_GNULIB=""
	AVOID_GNULIB+=" ac_cv_func_calloc_0_nonnull=yes"
	AVOID_GNULIB+=" ac_cv_func_chown_works=yes"
	AVOID_GNULIB+=" ac_cv_func_getgroups_works=yes"
	AVOID_GNULIB+=" ac_cv_func_malloc_0_nonnull=yes"
	AVOID_GNULIB+=" ac_cv_func_realloc_0_nonnull=yes"
	AVOID_GNULIB+=" am_cv_func_working_getline=yes"
	AVOID_GNULIB+=" gl_cv_func_dup2_works=yes"
	AVOID_GNULIB+=" gl_cv_func_fcntl_f_dupfd_cloexec=yes"
	AVOID_GNULIB+=" gl_cv_func_fcntl_f_dupfd_works=yes"
	AVOID_GNULIB+=" gl_cv_func_fnmatch_posix=yes"
	AVOID_GNULIB+=" gl_cv_func_getcwd_abort_bug=no"
	AVOID_GNULIB+=" gl_cv_func_getcwd_null=yes"
	AVOID_GNULIB+=" gl_cv_func_getcwd_path_max=yes"
	AVOID_GNULIB+=" gl_cv_func_getcwd_posix_signature=yes"
	AVOID_GNULIB+=" gl_cv_func_gettimeofday_clobber=no"
	AVOID_GNULIB+=" gl_cv_func_gettimeofday_posix_signature=yes"
	AVOID_GNULIB+=" gl_cv_func_link_works=yes"
	AVOID_GNULIB+=" gl_cv_func_lstat_dereferences_slashed_symlink=yes"
	AVOID_GNULIB+=" gl_cv_func_malloc_0_nonnull=yes"
	AVOID_GNULIB+=" gl_cv_func_memchr_works=yes"
	AVOID_GNULIB+=" gl_cv_func_mkdir_trailing_dot_works=yes"
	AVOID_GNULIB+=" gl_cv_func_mkdir_trailing_slash_works=yes"
	AVOID_GNULIB+=" gl_cv_func_mkfifo_works=yes"
	AVOID_GNULIB+=" gl_cv_func_mknod_works=yes"
	AVOID_GNULIB+=" gl_cv_func_realpath_works=yes"
	AVOID_GNULIB+=" gl_cv_func_select_detects_ebadf=yes"
	AVOID_GNULIB+=" gl_cv_func_snprintf_posix=yes"
	AVOID_GNULIB+=" gl_cv_func_snprintf_retval_c99=yes"
	AVOID_GNULIB+=" gl_cv_func_snprintf_truncation_c99=yes"
	AVOID_GNULIB+=" gl_cv_func_stat_dir_slash=yes"
	AVOID_GNULIB+=" gl_cv_func_stat_file_slash=yes"
	AVOID_GNULIB+=" gl_cv_func_strerror_0_works=yes"
	AVOID_GNULIB+=" gl_cv_func_symlink_works=yes"
	AVOID_GNULIB+=" gl_cv_func_tzset_clobber=no"
	AVOID_GNULIB+=" gl_cv_func_unlink_honors_slashes=yes"
	AVOID_GNULIB+=" gl_cv_func_unlink_honors_slashes=yes"
	AVOID_GNULIB+=" gl_cv_func_vsnprintf_posix=yes"
	AVOID_GNULIB+=" gl_cv_func_vsnprintf_zerosize_c99=yes"
	AVOID_GNULIB+=" gl_cv_func_wcwidth_works=yes"
	AVOID_GNULIB+=" gl_cv_func_working_getdelim=yes"
	AVOID_GNULIB+=" gl_cv_func_working_mkstemp=yes"
	AVOID_GNULIB+=" gl_cv_func_working_mktime=yes"
	AVOID_GNULIB+=" gl_cv_func_working_strerror=yes"
	AVOID_GNULIB+=" gl_cv_header_working_fcntl_h=yes"
	AVOID_GNULIB+=" gl_cv_C_locale_sans_EILSEQ=yes"

	# NOTE: We do not want to quote AVOID_GNULIB as we want word expansion.
	# shellcheck disable=SC2086
	env $AVOID_GNULIB "$LINUXDROID_PKG_SRCDIR/configure" \
		--disable-dependency-tracking \
		--prefix=$LINUXDROID_PREFIX \
		--libdir=$LINUXDROID_PREFIX/lib \
		--disable-rpath --disable-rpath-hack \
		$HOST_FLAG \
		$LINUXDROID_PKG_EXTRA_CONFIGURE_ARGS \
		$DISABLE_NLS \
		$ENABLE_SHARED \
		$DISABLE_STATIC \
		$LIBEXEC_FLAG \
		$QUIET_BUILD
}

linuxdroid_step_configure_cmake () {
	linuxdroid_setup_cmake

	local TOOLCHAIN_ARGS="-DCMAKE_ANDROID_STANDALONE_TOOLCHAIN=$LINUXDROID_STANDALONE_TOOLCHAIN"
	local BUILD_TYPE=MinSizeRel
	test -n "$LINUXDROID_DEBUG" && BUILD_TYPE=Debug

	local CMAKE_PROC=$LINUXDROID_ARCH
	test $CMAKE_PROC == "arm" && CMAKE_PROC='armv7-a'
	local MAKE_PROGRAM_PATH
	if [ $LINUXDROID_CMAKE_BUILD = Ninja ]; then
		linuxdroid_setup_ninja
		MAKE_PROGRAM_PATH=`which ninja`
	else
		MAKE_PROGRAM_PATH=`which make`
	fi

	# XXX: CMAKE_{AR,RANLIB} needed for at least jsoncpp build to not
	# pick up cross compiled binutils tool in $PREFIX/bin:
	cmake -G "$LINUXDROID_CMAKE_BUILD" "$LINUXDROID_PKG_SRCDIR" \
		-DCMAKE_AR="$(which $AR)" \
		-DCMAKE_UNAME="$(which uname)" \
		-DCMAKE_RANLIB="$(which $RANLIB)" \
		-DCMAKE_BUILD_TYPE=$BUILD_TYPE \
		-DCMAKE_CROSSCOMPILING=True \
		-DCMAKE_C_FLAGS="$CFLAGS $CPPFLAGS" \
		-DCMAKE_CXX_FLAGS="$CXXFLAGS $CPPFLAGS" \
		-DCMAKE_LINKER="$LINUXDROID_STANDALONE_TOOLCHAIN/bin/$LD $LDFLAGS" \
		-DCMAKE_FIND_ROOT_PATH=$LINUXDROID_PREFIX \
		-DCMAKE_FIND_ROOT_PATH_MODE_INCLUDE=ONLY \
		-DCMAKE_FIND_ROOT_PATH_MODE_LIBRARY=ONLY \
		-DCMAKE_INSTALL_PREFIX=$LINUXDROID_PREFIX \
		-DCMAKE_MAKE_PROGRAM=$MAKE_PROGRAM_PATH \
		-DCMAKE_SYSTEM_PROCESSOR=$CMAKE_PROC \
		-DCMAKE_SYSTEM_NAME=Android \
		-DCMAKE_SYSTEM_VERSION=$LINUXDROID_PKG_API_LEVEL \
		-DCMAKE_SKIP_INSTALL_RPATH=ON \
		-DCMAKE_USE_SYSTEM_LIBRARIES=True \
		-DDOXYGEN_EXECUTABLE= \
		-DBUILD_TESTING=OFF \
		$LINUXDROID_PKG_EXTRA_CONFIGURE_ARGS $TOOLCHAIN_ARGS
}

linuxdroid_step_configure_meson () {
	linuxdroid_setup_meson
	CC=gcc CXX=g++ $LINUXDROID_MESON \
		$LINUXDROID_PKG_SRCDIR \
		$LINUXDROID_PKG_BUILDDIR \
		--cross-file $LINUXDROID_MESON_CROSSFILE \
		--prefix $LINUXDROID_PREFIX \
		--libdir lib \
		--buildtype minsize \
		--strip \
		$LINUXDROID_PKG_EXTRA_CONFIGURE_ARGS
}

linuxdroid_step_configure () {
	if [ "$LINUXDROID_PKG_FORCE_CMAKE" == 'no' ] && [ -f "$LINUXDROID_PKG_SRCDIR/configure" ]; then
		linuxdroid_step_configure_autotools
	elif [ -f "$LINUXDROID_PKG_SRCDIR/CMakeLists.txt" ]; then
		linuxdroid_step_configure_cmake
	elif [ -f "$LINUXDROID_PKG_SRCDIR/meson.build" ]; then
		linuxdroid_step_configure_meson
	fi
}

linuxdroid_step_post_configure () {
	return
}

linuxdroid_step_make() {
	local QUIET_BUILD=
	if [ ! -z ${LINUXDROID_QUIET_BUILD+x} ]; then
		QUIET_BUILD="-s"
	fi

	if test -f build.ninja; then
		ninja -j $LINUXDROID_MAKE_PROCESSES
	elif ls ./*akefile &> /dev/null || [ ! -z "$LINUXDROID_PKG_EXTRA_MAKE_ARGS" ]; then
		if [ -z "$LINUXDROID_PKG_EXTRA_MAKE_ARGS" ]; then
			make -j $LINUXDROID_MAKE_PROCESSES $QUIET_BUILD
		else
			make -j $LINUXDROID_MAKE_PROCESSES $QUIET_BUILD ${LINUXDROID_PKG_EXTRA_MAKE_ARGS}
		fi
	fi
}

linuxdroid_step_make_install() {
	if test -f build.ninja; then
		ninja -j $LINUXDROID_MAKE_PROCESSES install
	elif ls ./*akefile &> /dev/null || [ ! -z "$LINUXDROID_PKG_EXTRA_MAKE_ARGS" ]; then
		: "${LINUXDROID_PKG_MAKE_INSTALL_TARGET:="install"}"
		# Some packages have problem with parallell install, and it does not buy much, so use -j 1.
		if [ -z "$LINUXDROID_PKG_EXTRA_MAKE_ARGS" ]; then
			make -j 1 ${LINUXDROID_PKG_MAKE_INSTALL_TARGET}
		else
			make -j 1 ${LINUXDROID_PKG_EXTRA_MAKE_ARGS} ${LINUXDROID_PKG_MAKE_INSTALL_TARGET}
		fi
	elif test -f Cargo.toml; then
		linuxdroid_setup_rust
		cargo install --force \
			--target $CARGO_TARGET_NAME \
			--root $LINUXDROID_PREFIX \
			$LINUXDROID_PKG_EXTRA_CONFIGURE_ARGS
		# https://github.com/rust-lang/cargo/issues/3316:
		rm $LINUXDROID_PREFIX/.crates.toml
	fi
}

# Hook function for package scripts to override.
linuxdroid_step_post_make_install() {
	return
}

linuxdroid_step_extract_into_massagedir() {
	local TARBALL_ORIG=$LINUXDROID_PKG_PACKAGEDIR/${LINUXDROID_PKG_NAME}_orig.tar.gz

	# Build diff tar with what has changed during the build:
	cd $LINUXDROID_PREFIX
	tar -N "$LINUXDROID_BUILD_TS_FILE" \
		--exclude='lib/libc++_shared.so' --exclude='lib/libstdc++.so' \
		-czf "$TARBALL_ORIG" .

	# Extract tar in order to massage it
	mkdir -p "$LINUXDROID_PKG_MASSAGEDIR/$LINUXDROID_PREFIX"
	cd "$LINUXDROID_PKG_MASSAGEDIR/$LINUXDROID_PREFIX"
	tar xf "$TARBALL_ORIG"
	rm "$TARBALL_ORIG"
}

linuxdroid_step_massage() {
	cd "$LINUXDROID_PKG_MASSAGEDIR/$LINUXDROID_PREFIX"

	# Remove lib/charset.alias which is installed by gettext-using packages:
	rm -f lib/charset.alias

	# Remove non-english man pages:
	test -d share/man && (cd share/man; for f in `ls | grep -v man`; do rm -Rf $f; done )

	if [ -z "${LINUXDROID_PKG_KEEP_INFOPAGES+x}" ]; then
		# Remove info pages:
		rm -Rf share/info
	fi

	# Remove locale files we're not interested in::
	rm -Rf share/locale
	if [ -z "${LINUXDROID_PKG_KEEP_SHARE_DOC+x}" ]; then
		# Remove info pages:
		rm -Rf share/doc
	fi

	# Remove old kept libraries (readline):
	find . -name '*.old' -delete

	# Remove static libraries:
	if [ $LINUXDROID_PKG_KEEP_STATIC_LIBRARIES = "false" ]; then
		find . -name '*.a' -delete
		find . -name '*.la' -delete
	fi

	# Move over sbin to bin:
	for file in sbin/*; do if test -f "$file"; then mv "$file" bin/; fi; done

	# Remove world permissions and add write permissions.
	# The -f flag is used to suppress warnings about dangling symlinks (such
	# as ones to /system/... which may not exist on the build machine):
        find . -exec chmod -f u+w,g-rwx,o-rwx \{\} \;

	if [ "$LINUXDROID_DEBUG" = "" ]; then
		# Strip binaries. file(1) may fail for certain unusual files, so disable pipefail.
		set +e +o pipefail
		find . -type f | xargs -r file | grep -E "(executable|shared object)" | grep ELF | cut -f 1 -d : | \
			xargs -r "$STRIP" --strip-unneeded --preserve-dates
		set -e -o pipefail
	fi
	# Remove DT_ entries which the android 5.1 linker warns about:
	find . -type f -print0 | xargs -r -0 "$LINUXDROID_ELF_CLEANER"

	# Fix shebang paths:
	while IFS= read -r -d '' file
	do
		head -c 100 "$file" | grep -E "^#\!.*\\/bin\\/.*" | grep -q -E -v "^#\! ?\\/system" && sed --follow-symlinks -i -E "1 s@^#\!(.*)/bin/(.*)@#\!$LINUXDROID_PREFIX/bin/\2@" "$file"
	done < <(find -L . -type f -print0)

	test ! -z "$LINUXDROID_PKG_RM_AFTER_INSTALL" && rm -Rf $LINUXDROID_PKG_RM_AFTER_INSTALL

	find . -type d -empty -delete # Remove empty directories

	# Sub packages:
	if [ -d include ] && [ -z "${LINUXDROID_PKG_NO_DEVELSPLIT}" ]; then
		# Add virtual -dev sub package if there are include files:
		local _DEVEL_SUBPACKAGE_FILE=$LINUXDROID_PKG_TMPDIR/${LINUXDROID_PKG_NAME}-dev.subpackage.sh
		echo LINUXDROID_SUBPKG_INCLUDE=\"include share/vala share/man/man3 lib/pkgconfig share/aclocal lib/cmake $LINUXDROID_PKG_INCLUDE_IN_DEVPACKAGE\" > "$_DEVEL_SUBPACKAGE_FILE"
		echo "LINUXDROID_SUBPKG_DESCRIPTION=\"Development files for ${LINUXDROID_PKG_NAME}\"" >> "$_DEVEL_SUBPACKAGE_FILE"
		if [ -n "$LINUXDROID_PKG_DEVPACKAGE_DEPENDS" ]; then
			echo "LINUXDROID_SUBPKG_DEPENDS=\"$LINUXDROID_PKG_NAME,$LINUXDROID_PKG_DEVPACKAGE_DEPENDS\"" >> "$_DEVEL_SUBPACKAGE_FILE"
		else
			echo "LINUXDROID_SUBPKG_DEPENDS=\"$LINUXDROID_PKG_NAME\"" >> "$_DEVEL_SUBPACKAGE_FILE"
		fi
	fi
	# Now build all sub packages
	rm -Rf "$LINUXDROID_TOPDIR/$LINUXDROID_PKG_NAME/subpackages"
	for subpackage in $LINUXDROID_PKG_BUILDER_DIR/*.subpackage.sh $LINUXDROID_PKG_TMPDIR/*subpackage.sh; do
		test ! -f "$subpackage" && continue
		local SUB_PKG_NAME
		SUB_PKG_NAME=$(basename "$subpackage" .subpackage.sh)
		# Default value is same as main package, but sub package may override:
		local LINUXDROID_SUBPKG_PLATFORM_INDEPENDENT=$LINUXDROID_PKG_PLATFORM_INDEPENDENT
		local SUB_PKG_DIR=$LINUXDROID_TOPDIR/$LINUXDROID_PKG_NAME/subpackages/$SUB_PKG_NAME
		local LINUXDROID_SUBPKG_DEPENDS=""
		local LINUXDROID_SUBPKG_CONFLICTS=""
		local LINUXDROID_SUBPKG_REPLACES=""
		local LINUXDROID_SUBPKG_CONFFILES=""
		local SUB_PKG_MASSAGE_DIR=$SUB_PKG_DIR/massage/$LINUXDROID_PREFIX
		local SUB_PKG_PACKAGE_DIR=$SUB_PKG_DIR/package
		mkdir -p "$SUB_PKG_MASSAGE_DIR" "$SUB_PKG_PACKAGE_DIR"

		# shellcheck source=/dev/null
		source "$subpackage"

		for includeset in $LINUXDROID_SUBPKG_INCLUDE; do
			local _INCLUDE_DIRSET
			_INCLUDE_DIRSET=$(dirname "$includeset")
			test "$_INCLUDE_DIRSET" = "." && _INCLUDE_DIRSET=""
			if [ -e "$includeset" ] || [ -L "$includeset" ]; then
				# Add the -L clause to handle relative symbolic links:
				mkdir -p "$SUB_PKG_MASSAGE_DIR/$_INCLUDE_DIRSET"
				mv "$includeset" "$SUB_PKG_MASSAGE_DIR/$_INCLUDE_DIRSET"
			fi
		done

		local SUB_PKG_ARCH=$LINUXDROID_ARCH
		test -n "$LINUXDROID_SUBPKG_PLATFORM_INDEPENDENT" && SUB_PKG_ARCH=all

		cd "$SUB_PKG_DIR/massage"
		local SUB_PKG_INSTALLSIZE
		SUB_PKG_INSTALLSIZE=$(du -sk . | cut -f 1)
		tar -cJf "$SUB_PKG_PACKAGE_DIR/data.tar.xz" .

		mkdir -p DEBIAN
		cd DEBIAN
		cat > control <<-HERE
			Package: $SUB_PKG_NAME
			Architecture: ${SUB_PKG_ARCH}
			Installed-Size: ${SUB_PKG_INSTALLSIZE}
			Maintainer: $LINUXDROID_PKG_MAINTAINER
			Version: $LINUXDROID_PKG_FULLVERSION
			Description: $LINUXDROID_SUBPKG_DESCRIPTION
			Homepage: $LINUXDROID_PKG_HOMEPAGE
		HERE
		test ! -z "$LINUXDROID_SUBPKG_DEPENDS" && echo "Depends: $LINUXDROID_SUBPKG_DEPENDS" >> control
		test ! -z "$LINUXDROID_SUBPKG_CONFLICTS" && echo "Conflicts: $LINUXDROID_SUBPKG_CONFLICTS" >> control
		test ! -z "$LINUXDROID_SUBPKG_REPLACES" && echo "Replaces: $LINUXDROID_SUBPKG_REPLACES" >> control
		tar -cJf "$SUB_PKG_PACKAGE_DIR/control.tar.xz" .

		for f in $LINUXDROID_SUBPKG_CONFFILES; do echo "$LINUXDROID_PREFIX/$f" >> conffiles; done

		# Create the actual .deb file:
		LINUXDROID_SUBPKG_DEBFILE=$LINUXDROID_DEBDIR/${SUB_PKG_NAME}${DEBUG}_${LINUXDROID_PKG_FULLVERSION}_${SUB_PKG_ARCH}.deb
		test ! -f "$LINUXDROID_COMMON_CACHEDIR/debian-binary" && echo "2.0" > "$LINUXDROID_COMMON_CACHEDIR/debian-binary"
		ar cr "$LINUXDROID_SUBPKG_DEBFILE" \
				   "$LINUXDROID_COMMON_CACHEDIR/debian-binary" \
				   "$SUB_PKG_PACKAGE_DIR/control.tar.xz" \
				   "$SUB_PKG_PACKAGE_DIR/data.tar.xz"

		# Go back to main package:
		cd "$LINUXDROID_PKG_MASSAGEDIR/$LINUXDROID_PREFIX"
	done

	# .. remove empty directories (NOTE: keep this last):
	find . -type d -empty -delete
	# Make sure user can read and write all files (problem with dpkg otherwise):
	chmod -R u+rw .
}

linuxdroid_step_post_massage() {
	return
}

# Create data.tar.gz with files to package. Not to be overridden by package scripts.
linuxdroid_step_create_datatar() {
	# Create data tarball containing files to package:
	cd "$LINUXDROID_PKG_MASSAGEDIR"

	local HARDLINKS
	HARDLINKS="$(find . -type f -links +1)"
	if [ -n "$HARDLINKS" ]; then
		linuxdroid_error_exit "Package contains hard links: $HARDLINKS"
	fi

	if [ -z "${LINUXDROID_PKG_METAPACKAGE+x}" ] && [ "$(find . -type f)" = "" ]; then
		linuxdroid_error_exit "No files in package"
	fi
	tar -cJf "$LINUXDROID_PKG_PACKAGEDIR/data.tar.xz" .
}

linuxdroid_step_create_debscripts() {
	return
}

# Create the build deb file. Not to be overridden by package scripts.
linuxdroid_step_create_debfile() {
	# Get install size. This will be written as the "Installed-Size" deb field so is measured in 1024-byte blocks:
	local LINUXDROID_PKG_INSTALLSIZE
	LINUXDROID_PKG_INSTALLSIZE=$(du -sk . | cut -f 1)

	# From here on LINUXDROID_ARCH is set to "all" if LINUXDROID_PKG_PLATFORM_INDEPENDENT is set by the package
	test -n "$LINUXDROID_PKG_PLATFORM_INDEPENDENT" && LINUXDROID_ARCH=all

	mkdir -p DEBIAN
	cat > DEBIAN/control <<-HERE
		Package: $LINUXDROID_PKG_NAME
		Architecture: ${LINUXDROID_ARCH}
		Installed-Size: ${LINUXDROID_PKG_INSTALLSIZE}
		Maintainer: $LINUXDROID_PKG_MAINTAINER
		Version: $LINUXDROID_PKG_FULLVERSION
		Description: $LINUXDROID_PKG_DESCRIPTION
		Homepage: $LINUXDROID_PKG_HOMEPAGE
	HERE
	test ! -z "$LINUXDROID_PKG_BREAKS" && echo "Breaks: $LINUXDROID_PKG_BREAKS" >> DEBIAN/control
	test ! -z "$LINUXDROID_PKG_DEPENDS" && echo "Depends: $LINUXDROID_PKG_DEPENDS" >> DEBIAN/control
	test ! -z "$LINUXDROID_PKG_ESSENTIAL" && echo "Essential: yes" >> DEBIAN/control
	test ! -z "$LINUXDROID_PKG_CONFLICTS" && echo "Conflicts: $LINUXDROID_PKG_CONFLICTS" >> DEBIAN/control
	test ! -z "$LINUXDROID_PKG_RECOMMENDS" && echo "Recommends: $LINUXDROID_PKG_RECOMMENDS" >> DEBIAN/control
	test ! -z "$LINUXDROID_PKG_REPLACES" && echo "Replaces: $LINUXDROID_PKG_REPLACES" >> DEBIAN/control
	test ! -z "$LINUXDROID_PKG_PROVIDES" && echo "Provides: $LINUXDROID_PKG_PROVIDES" >> DEBIAN/control
	test ! -z "$LINUXDROID_PKG_SUGGESTS" && echo "Suggests: $LINUXDROID_PKG_SUGGESTS" >> DEBIAN/control

	# Create DEBIAN/conffiles (see https://www.debian.org/doc/debian-policy/ap-pkg-conffiles.html):
	for f in $LINUXDROID_PKG_CONFFILES; do echo "$LINUXDROID_PREFIX/$f" >> DEBIAN/conffiles; done

	# Allow packages to create arbitrary control files.
	# XXX: Should be done in a better way without a function?
	cd DEBIAN
	linuxdroid_step_create_debscripts

	# Create control.tar.xz
	tar -cJf "$LINUXDROID_PKG_PACKAGEDIR/control.tar.xz" .

	test ! -f "$LINUXDROID_COMMON_CACHEDIR/debian-binary" && echo "2.0" > "$LINUXDROID_COMMON_CACHEDIR/debian-binary"
	LINUXDROID_PKG_DEBFILE=$LINUXDROID_DEBDIR/${LINUXDROID_PKG_NAME}${DEBUG}_${LINUXDROID_PKG_FULLVERSION}_${LINUXDROID_ARCH}.deb
	# Create the actual .deb file:
	ar cr "$LINUXDROID_PKG_DEBFILE" \
	       "$LINUXDROID_COMMON_CACHEDIR/debian-binary" \
	       "$LINUXDROID_PKG_PACKAGEDIR/control.tar.xz" \
	       "$LINUXDROID_PKG_PACKAGEDIR/data.tar.xz"
}

# Finish the build. Not to be overridden by package scripts.
linuxdroid_step_finish_build() {
	echo "linuxdroid - build of '$LINUXDROID_PKG_NAME' done"
	test -t 1 && printf "\033]0;%s - DONE\007" "$LINUXDROID_PKG_NAME"
	mkdir -p /data/data/.built-packages
	echo "$LINUXDROID_PKG_FULLVERSION" > "/data/data/.built-packages/$LINUXDROID_PKG_NAME"
	exit 0
}

linuxdroid_step_handle_arguments "$@"
linuxdroid_step_setup_variables
linuxdroid_step_handle_buildarch
linuxdroid_step_start_build
linuxdroid_step_extract_package
cd "$LINUXDROID_PKG_SRCDIR"
linuxdroid_step_post_extract_package
linuxdroid_step_handle_hostbuild
linuxdroid_step_setup_toolchain
linuxdroid_step_patch_package
linuxdroid_step_replace_guess_scripts
cd "$LINUXDROID_PKG_SRCDIR"
linuxdroid_step_pre_configure
cd "$LINUXDROID_PKG_BUILDDIR"
linuxdroid_step_configure
cd "$LINUXDROID_PKG_BUILDDIR"
linuxdroid_step_post_configure
cd "$LINUXDROID_PKG_BUILDDIR"
linuxdroid_step_make
cd "$LINUXDROID_PKG_BUILDDIR"
linuxdroid_step_make_install
cd "$LINUXDROID_PKG_BUILDDIR"
linuxdroid_step_post_make_install
cd "$LINUXDROID_PKG_MASSAGEDIR"
linuxdroid_step_extract_into_massagedir
cd "$LINUXDROID_PKG_MASSAGEDIR"
linuxdroid_step_massage
cd "$LINUXDROID_PKG_MASSAGEDIR/$LINUXDROID_PREFIX"
linuxdroid_step_post_massage
linuxdroid_step_create_datatar
linuxdroid_step_create_debfile
linuxdroid_step_finish_build

#!/usr/bin/env bash

. scripts/properties.sh

check_package() { # path
	local path=$1
	local pkg=`basename $path`
	MININIX_PKG_REVISION=0
	MININIX_ARCH=aarch64
	. $path/build.sh
	if [ "$MININIX_PKG_REVISION" != "0" ] || [ "$MININIX_PKG_VERSION" != "${MININIX_PKG_VERSION/-/}" ]; then
		MININIX_PKG_VERSION+="-$MININIX_PKG_REVISION"
	fi
	echo "$pkg=$MININIX_PKG_VERSION"
}

for path in packages/*; do
(
	check_package $path
)
done

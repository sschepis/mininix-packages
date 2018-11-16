#!/usr/bin/env bash

. scripts/properties.sh

check_package() { # path
	local path=$1
	local pkg=`basename $path`
	LINUXDROID_PKG_REVISION=0
	LINUXDROID_ARCH=aarch64
	. $path/build.sh
	if [ "$LINUXDROID_PKG_REVISION" != "0" ] || [ "$LINUXDROID_PKG_VERSION" != "${LINUXDROID_PKG_VERSION/-/}" ]; then
		LINUXDROID_PKG_VERSION+="-$LINUXDROID_PKG_REVISION"
	fi
	echo "$pkg=$LINUXDROID_PKG_VERSION"
}

for path in packages/*; do
(
	check_package $path
)
done

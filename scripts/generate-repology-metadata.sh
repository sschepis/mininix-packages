#!/usr/bin/env bash

set -e

check_package() { # path
	# Avoid ending on errors such as `which prog`
	# where prog is not installed.
	set +e

	local path=$1
	local pkg=`basename $path`
	LINUXDROID_PKG_MAINTAINER="Fredrik Fornwall @fornwall"
	. $path/build.sh

	echo "  {"
	echo "    \"name\": \"$pkg\","
	echo "    \"version\": \"$LINUXDROID_PKG_VERSION\","
	DESC=`echo $LINUXDROID_PKG_DESCRIPTION | head -n 1`
	echo "    \"description\": \"$DESC\","
	echo "    \"homepage\": \"$LINUXDROID_PKG_HOMEPAGE\","

	echo -n "    \"depends\": ["
	FIRST_DEP=yes
	for p in ${LINUXDROID_PKG_DEPENDS//,/ }; do
		if [ $FIRST_DEP = yes ]; then
			FIRST_DEP=no
		else
			echo -n ", "
		fi
		echo -n "\"$p\""
	done
	echo "],"

	if [ "$LINUXDROID_PKG_SRCURL" != "" ]; then
		echo "    \"srcurl\": \"$LINUXDROID_PKG_SRCURL\","
	fi

	echo "    \"maintainer\": \"$LINUXDROID_PKG_MAINTAINER\""
	echo -n "  }"
}

. scripts/properties.sh
export LINUXDROID_ARCH=aarch64

echo '['

export FIRST=yes
# Run each package in separate process since we include their environment variables:
for path in packages/*; do
	
	if [ $FIRST = yes ]; then
		FIRST=no
	else
		echo -n ","
		echo ""
	fi

	( check_package $path)
done

echo ""
echo ']'

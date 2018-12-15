#!/usr/bin/env bash

set -e

check_package() { # path
	# Avoid ending on errors such as `which prog`
	# where prog is not installed.
	set +e

	local path=$1
	local pkg=`basename $path`
	MININIX_PKG_MAINTAINER="Fredrik Fornwall @fornwall"
	. $path/build.sh

	echo "  {"
	echo "    \"name\": \"$pkg\","
	echo "    \"version\": \"$MININIX_PKG_VERSION\","
	DESC=`echo $MININIX_PKG_DESCRIPTION | head -n 1`
	echo "    \"description\": \"$DESC\","
	echo "    \"homepage\": \"$MININIX_PKG_HOMEPAGE\","

	echo -n "    \"depends\": ["
	FIRST_DEP=yes
	for p in ${MININIX_PKG_DEPENDS//,/ }; do
		if [ $FIRST_DEP = yes ]; then
			FIRST_DEP=no
		else
			echo -n ", "
		fi
		echo -n "\"$p\""
	done
	echo "],"

	if [ "$MININIX_PKG_SRCURL" != "" ]; then
		echo "    \"srcurl\": \"$MININIX_PKG_SRCURL\","
	fi

	echo "    \"maintainer\": \"$MININIX_PKG_MAINTAINER\""
	echo -n "  }"
}

. scripts/properties.sh
export MININIX_ARCH=aarch64

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

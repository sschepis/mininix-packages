MININIX_PKG_HOMEPAGE=https://www.gpsbabel.org/
MININIX_PKG_DESCRIPTION="GPS file conversion plus transfer to/from GPS units"
MININIX_PKG_VERSION=1.4.4
MININIX_PKG_SHA256=22860e913f093aa9124e295d52d1d4ae1afccaa67ed6bed6f1f8d8b0a45336d1
MININIX_PKG_SRCURL=https://github.com/gpsbabel/gpsbabel/archive/gpsbabel_${MININIX_PKG_VERSION//./_}.tar.gz
MININIX_PKG_DEPENDS="libexpat"

mininix_step_post_extract_package () {
	MININIX_PKG_SRCDIR+=/gpsbabel
}

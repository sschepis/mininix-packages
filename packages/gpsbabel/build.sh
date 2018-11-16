LINUXDROID_PKG_HOMEPAGE=https://www.gpsbabel.org/
LINUXDROID_PKG_DESCRIPTION="GPS file conversion plus transfer to/from GPS units"
LINUXDROID_PKG_VERSION=1.4.4
LINUXDROID_PKG_SHA256=22860e913f093aa9124e295d52d1d4ae1afccaa67ed6bed6f1f8d8b0a45336d1
LINUXDROID_PKG_SRCURL=https://github.com/gpsbabel/gpsbabel/archive/gpsbabel_${LINUXDROID_PKG_VERSION//./_}.tar.gz
LINUXDROID_PKG_DEPENDS="libexpat"

linuxdroid_step_post_extract_package () {
	LINUXDROID_PKG_SRCDIR+=/gpsbabel
}

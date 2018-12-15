MININIX_PKG_HOMEPAGE=https://github.com/tesseract-ocr/tesseract
MININIX_PKG_DESCRIPTION="Tesseract is probably the most accurate open source OCR engine available"
MININIX_PKG_VERSION=3.05.02
MININIX_PKG_REVISION=1
MININIX_PKG_SHA256=494d64ffa7069498a97b909a0e65a35a213989e0184f1ea15332933a90d43445
MININIX_PKG_SRCURL=https://github.com/tesseract-ocr/tesseract/archive/${MININIX_PKG_VERSION}.tar.gz
MININIX_PKG_DEPENDS="libtool, libuuid, leptonica"

mininix_step_pre_configure() {
	# http://blog.matt-swain.com/post/26419042500/installing-tesseract-ocr-on-mac-os-x-lion
	export LIBLEPT_HEADERSDIR=${MININIX_PREFIX}/include/leptonica

	perl -p -i -e 's|ADD_RT], true|ADD_RT], false|g' configure.ac
	./autogen.sh
}

mininix_step_post_make_install() {
	# download english trained data
	cd "${MININIX_PREFIX}/share/tessdata"
	rm -f eng.*

	local checksums
	declare -A checksums
	checksums[cube.bigrams]=64adf2cc0b2a6705368aa357224d1a6739035d5fe892cd0cc457016df5b4280f
	checksums[cube.fold]=2b229895623934b493fe69c51fcc387295d91af8b4e43cc51748b3d269a95eed
	checksums[cube.lm]=a6f769245b0a55f42a3ce157cd19d96828483c3384c6483433ed83579ea16e36
	checksums[cube.nn]=8f345f1c19772dd71a5214bc94175ccf647c003ab77e4143fde48f11bf3cb0ef
	checksums[cube.params]=c2aa2854951bd823d89cc86d53a6d9712a6a885de6fbaf650ff3df48bfed85d7
	checksums[cube.size]=e5f95de7e2754eb2df03451885277ca4573b3770816043ae2e2f09d1f7232604
	checksums[cube.word-freq]=8d612bef20ae3052fce0b8650575a80d87c94d772ec6d1f0c6a1ad591586ea44
	checksums[tesseract_cube.nn]=196bedc8a5bc8c30361c2c9518f648b45b498759cb6041827ff6fbfb8da2a8d1
	checksums[traineddata]=c0515c9f1e0c79e1069fcc05c2b2f6a6841fb5e1082d695db160333c1154f06d

	mkdir -p $MININIX_PKG_CACHEDIR/tessdata

	local f
	for f in cube.{bigrams,fold,lm,nn,params,size,word-freq} tesseract_cube.nn traineddata; do
		# From the tessdata README: "These language data files only work with
		# Tesseract 4. They are based on the sources in tesseract-ocr/langdata on GitHub.
		# Get language data files for Tesseract 3.04 or 3.05 from the 3.04 tree."
		mininix_download \
			https://raw.githubusercontent.com/tesseract-ocr/tessdata/3.04.00/eng.$f \
			$MININIX_PKG_CACHEDIR/tessdata/eng.$f \
			${checksums[$f]}
		cp $MININIX_PKG_CACHEDIR/tessdata/eng.$f .
	done
}

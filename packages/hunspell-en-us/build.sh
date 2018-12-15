MININIX_PKG_HOMEPAGE=https://hunspell.github.io
MININIX_PKG_DESCRIPTION="American english dictionary for hunspell"
MININIX_PKG_VERSION=2018.10.25
MININIX_PKG_PLATFORM_INDEPENDENT=yes

mininix_step_make_install () {
	mkdir -p $MININIX_PREFIX/share/hunspell/
	# On checksum mismatch the files may have been updated:
	#  https://cgit.freedesktop.org/libreoffice/dictionaries/log/en/en_US.aff
	#  https://cgit.freedesktop.org/libreoffice/dictionaries/log/en/en_US.dic
	# In which case we need to bump version and checksum used.
	mininix_download https://cgit.freedesktop.org/libreoffice/dictionaries/plain/en/en_US.aff \
			$MININIX_PREFIX/share/hunspell/en_US.aff \
			c7a8c4d08c29d237880844b1623099f59092602f189be38ce3912e457ff38bc1
	mininix_download https://cgit.freedesktop.org/libreoffice/dictionaries/plain/en/en_US.dic \
			$MININIX_PREFIX/share/hunspell/en_US.dic \
			9eb52cdeab6c87a4988df7d2845caaa39cd9bdc93b45bc2e3c228f8070807767
	touch $MININIX_PREFIX/share/hunspell/en_US.{aff,dic}
}

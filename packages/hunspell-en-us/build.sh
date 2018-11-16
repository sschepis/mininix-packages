LINUXDROID_PKG_HOMEPAGE=https://hunspell.github.io
LINUXDROID_PKG_DESCRIPTION="American english dictionary for hunspell"
LINUXDROID_PKG_VERSION=2018.10.25
LINUXDROID_PKG_PLATFORM_INDEPENDENT=yes

linuxdroid_step_make_install () {
	mkdir -p $LINUXDROID_PREFIX/share/hunspell/
	# On checksum mismatch the files may have been updated:
	#  https://cgit.freedesktop.org/libreoffice/dictionaries/log/en/en_US.aff
	#  https://cgit.freedesktop.org/libreoffice/dictionaries/log/en/en_US.dic
	# In which case we need to bump version and checksum used.
	linuxdroid_download https://cgit.freedesktop.org/libreoffice/dictionaries/plain/en/en_US.aff \
			$LINUXDROID_PREFIX/share/hunspell/en_US.aff \
			c7a8c4d08c29d237880844b1623099f59092602f189be38ce3912e457ff38bc1
	linuxdroid_download https://cgit.freedesktop.org/libreoffice/dictionaries/plain/en/en_US.dic \
			$LINUXDROID_PREFIX/share/hunspell/en_US.dic \
			9eb52cdeab6c87a4988df7d2845caaa39cd9bdc93b45bc2e3c228f8070807767
	touch $LINUXDROID_PREFIX/share/hunspell/en_US.{aff,dic}
}

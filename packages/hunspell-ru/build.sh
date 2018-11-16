LINUXDROID_PKG_HOMEPAGE=https://hunspell.github.io
LINUXDROID_PKG_DESCRIPTION="Russian dictionary for hunspell"
LINUXDROID_PKG_VERSION=2017.03.03
LINUXDROID_PKG_PLATFORM_INDEPENDENT=yes

linuxdroid_step_make_install () {
	mkdir -p $LINUXDROID_PREFIX/share/hunspell/
	# On checksum mismatch the files may have been updated:
	#  https://cgit.freedesktop.org/libreoffice/dictionaries/log/ru_RU/ru_RU.aff
	#  https://cgit.freedesktop.org/libreoffice/dictionaries/log/ru_RU/ru_RU.dic
	# In which case we need to bump version and checksum used.
	linuxdroid_download https://cgit.freedesktop.org/libreoffice/dictionaries/plain/ru_RU/ru_RU.aff \
			$LINUXDROID_PREFIX/share/hunspell/ru_RU.aff \
                        709cf9b41208961226e995a3ab75a2da834aaf4f9707cb87cbb37d4943b6a50d
	linuxdroid_download https://cgit.freedesktop.org/libreoffice/dictionaries/plain/ru_RU/ru_RU.dic \
			$LINUXDROID_PREFIX/share/hunspell/ru_RU.dic \
                        c0d81126b0a905ccc6fd891c923b43d39b4ce449da5a333859229354c510168f
	touch $LINUXDROID_PREFIX/share/hunspell/ru_RU.{aff,dic}
}

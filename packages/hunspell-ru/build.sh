MININIX_PKG_HOMEPAGE=https://hunspell.github.io
MININIX_PKG_DESCRIPTION="Russian dictionary for hunspell"
MININIX_PKG_VERSION=2017.03.03
MININIX_PKG_PLATFORM_INDEPENDENT=yes

mininix_step_make_install () {
	mkdir -p $MININIX_PREFIX/share/hunspell/
	# On checksum mismatch the files may have been updated:
	#  https://cgit.freedesktop.org/libreoffice/dictionaries/log/ru_RU/ru_RU.aff
	#  https://cgit.freedesktop.org/libreoffice/dictionaries/log/ru_RU/ru_RU.dic
	# In which case we need to bump version and checksum used.
	mininix_download https://cgit.freedesktop.org/libreoffice/dictionaries/plain/ru_RU/ru_RU.aff \
			$MININIX_PREFIX/share/hunspell/ru_RU.aff \
                        709cf9b41208961226e995a3ab75a2da834aaf4f9707cb87cbb37d4943b6a50d
	mininix_download https://cgit.freedesktop.org/libreoffice/dictionaries/plain/ru_RU/ru_RU.dic \
			$MININIX_PREFIX/share/hunspell/ru_RU.dic \
                        c0d81126b0a905ccc6fd891c923b43d39b4ce449da5a333859229354c510168f
	touch $MININIX_PREFIX/share/hunspell/ru_RU.{aff,dic}
}

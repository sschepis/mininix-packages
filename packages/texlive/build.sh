MININIX_PKG_HOMEPAGE=https://www.tug.org/texlive/
MININIX_PKG_DESCRIPTION="TeX Live is a distribution of the TeX typesetting system."
MININIX_PKG_MAINTAINER="Henrik Grimler @Grimler91"
_MAJOR_VERSION=20180414
MININIX_PKG_VERSION=${_MAJOR_VERSION}
MININIX_PKG_REVISION=1
MININIX_PKG_SRCURL="ftp://ftp.tug.org/texlive/historic/${MININIX_PKG_VERSION:0:4}/texlive-$_MAJOR_VERSION-texmf.tar.xz"
MININIX_PKG_SHA256="bae2fa05ea1858b489f8138bea855c6d65829cf595c1fb219c5d65f4fe8b1fad"
MININIX_PKG_DEPENDS="perl, texlive-bin (>= 20180414)"
MININIX_PKG_CONFLICTS="texlive (<< 20170524-5), texlive-bin (<< 20180414)"
MININIX_PKG_RECOMMENDS="texlive-tlmgr"
MININIX_PKG_FOLDERNAME="texlive-$_MAJOR_VERSION-texmf"
MININIX_PKG_PLATFORM_INDEPENDENT=yes
MININIX_PKG_HAS_DEBUG=no

TL_FILE_LISTS="texlive-texmf.list"
TL_ROOT=$MININIX_PREFIX/share/texlive
TL_BINDIR=$MININIX_PREFIX/bin

mininix_step_extract_package() {
	mkdir -p "$MININIX_PKG_SRCDIR"
	
	cd "$MININIX_PKG_TMPDIR"
	local filename
	filename=$(basename "${MININIX_PKG_SRCURL}")
	local file="$MININIX_PKG_CACHEDIR/$filename"
	mininix_download "${MININIX_PKG_SRCURL}" "$file" "${MININIX_PKG_SHA256}"
	
	folder=${MININIX_PKG_FOLDERNAME}
	
	rm -Rf $folder
	echo "Extracting files listed in ${TL_FILE_LISTS} from $folder"
	tar xf "$file" $(paste -d'\0' <(for i in $(seq 1 $( wc -l < $MININIX_PKG_BUILDER_DIR/${TL_FILE_LISTS} )); do echo ${MININIX_PKG_FOLDERNAME}/; done ) $MININIX_PKG_BUILDER_DIR/${TL_FILE_LISTS} )
	cp -r ${MININIX_PKG_FOLDERNAME}/* "$MININIX_PKG_SRCDIR"
}

mininix_step_make() {
	cp -r $MININIX_PKG_SRCDIR/* $TL_ROOT/
	perl -I$TL_ROOT/tlpkg/ $TL_ROOT/texmf-dist/scripts/texlive/mktexlsr.pl $TL_ROOT/texmf-dist
}

mininix_step_create_debscripts () {
	# Clean texlive's folder if needed (run on upgrade)
	echo "#!$MININIX_PREFIX/bin/bash" > preinst
	echo "if [ -d $MININIX_PREFIX/opt/texlive ]; then echo 'Removing residual files from old version of TeX Live for Mininix'; rm -rf $PREFIX/opt/texlive; fi" >> preinst
	echo "exit 0" >> preinst
	chmod 0755 preinst
	
	echo "#!$MININIX_PREFIX/bin/bash" > postinst
	echo "mktexlsr $TL_ROOT/texmf-var" >> postinst
	echo "texlinks" >> postinst
	echo "echo ''" >> postinst
	echo "echo Welcome to TeX Live!" >> postinst
	echo "echo ''" >> postinst
	echo "echo 'TeX Live is a joint project of the TeX user groups around the world;'" >> postinst
	echo "echo 'please consider supporting it by joining the group best for you.'" >> postinst
	echo "echo 'The list of groups is available on the web at http://tug.org/usergroups.html.'" >> postinst
	echo "exit 0" >> postinst
	chmod 0755 postinst

	# Remove all files installed through tlmgr on removal
	echo "#!$MININIX_PREFIX/bin/bash" > prerm
	echo 'if [ $1 != "remove" ]; then exit 0; fi' >> prerm
	echo "echo Running texlinks --unlink" >> prerm
	echo "texlinks --unlink" >> prerm
	echo "echo Removing texmf-dist" >> prerm
	echo "rm -rf $TL_ROOT/texmf-dist" >> prerm
	echo "echo Removing texmf-var and tlpkg" >> prerm
	echo "rm -rf $TL_ROOT/{texmf-var,tlpkg/{texlive.tlpdb.*,tlpobj,backups}}" >> prerm
	echo "exit 0" >> prerm
	chmod 0755 prerm
}

MININIX_PKG_RM_AFTER_INSTALL="
share/texlive/README
share/texlive/README.usergroups
share/texlive/autorun.inf
share/texlive/doc.html
share/texlive/index.html
share/texlive/install-tl
share/texlive/install-tl-advanced.bat
share/texlive/install-tl-windows.bat
share/texlive/readme-html.dir/readme.ja.html
share/texlive/readme-html.dir/readme.ru.html
share/texlive/readme-html.dir/readme.zh-cn.html
share/texlive/readme-html.dir/readme.it.html
share/texlive/readme-html.dir/readme.es.html
share/texlive/readme-html.dir/readme.pl.html
share/texlive/readme-html.dir/readme.de.html
share/texlive/readme-html.dir/readme.fr.html
share/texlive/readme-html.dir/readme.sr.html
share/texlive/readme-html.dir/readme.pt-br.html
share/texlive/readme-html.dir/readme.en.html
share/texlive/readme-html.dir/readme.cs.html
share/texlive/readme-txt.dir/README.RU-koi8
share/texlive/readme-txt.dir/README.EN
share/texlive/readme-txt.dir/README.FR
share/texlive/readme-txt.dir/README.SK-il2
share/texlive/readme-txt.dir/README.SK-ascii
share/texlive/readme-txt.dir/README.RU
share/texlive/readme-txt.dir/README.IT
share/texlive/readme-txt.dir/README.CS
share/texlive/readme-txt.dir/README.JA
share/texlive/readme-txt.dir/README.ES
share/texlive/readme-txt.dir/README.ZH-CN
share/texlive/readme-txt.dir/README.DE
share/texlive/readme-txt.dir/README.PL
share/texlive/readme-txt.dir/README.SK-cp1250
share/texlive/readme-txt.dir/README.SR
share/texlive/readme-txt.dir/README.PT-BR
share/texlive/readme-txt.dir/README.RU-cp1251
share/texlive/tl-tray-menu.exe
share/texlive/tlpkg/tlpostcode/xetex.pl
share/texlive/tlpkg/tlpostcode/xetex/conf/fonts.conf
share/texlive/tlpkg/tlpostcode/xetex/conf/fonts.dtd
share/texlive/tlpkg/tlpostcode/xetex/conf/conf.d/51-local.conf
share/texlive/tlpkg/tlpostcode/xetex/cache/readme.txt
share/texlive/tlpkg/tlpostcode/ptex2pdf-tlpost.pl
share/texlive/texmf-dist/web2c/texmf.cnf
share/texlive/texmf-dist/scripts/texlive/fmtutil-user.sh
share/texlive/texmf-dist/scripts/texlive/rungs.tlu
share/texlive/texmf-dist/scripts/texlive/updmap-user.sh
share/texlive/texmf-dist/scripts/texlive/tlmgr.pl
share/texlive/texmf-dist/scripts/texlive/tlmgrgui.pl"

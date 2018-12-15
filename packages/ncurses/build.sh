MININIX_PKG_HOMEPAGE=http://invisible-island.net/ncurses/
MININIX_PKG_DESCRIPTION="Library for text-based user interfaces in a terminal-independent manner"
MININIX_PKG_VERSION=(6.1.20181117
		    9.22)
MININIX_PKG_SHA256=(b5568d53d31787cda727f949b68bcb60c667dba5deff72bd7ade40dbe45e4b16
		   e94628e9bcfa0adb1115d83649f898d6edb4baced44f5d5b769c2eeb8b95addd)
MININIX_PKG_SRCURL=(https://dl.bintray.com/mininix/upstream/ncurses-${MININIX_PKG_VERSION:0:3}-${MININIX_PKG_VERSION:4}.tgz
		   https://fossies.org/linux/misc/rxvt-unicode-${MININIX_PKG_VERSION[1]}.tar.bz2)
# --without-normal disables static libraries:
# --disable-stripping to disable -s argument to install which does not work when cross compiling:
MININIX_PKG_EXTRA_CONFIGURE_ARGS="
ac_cv_header_locale_h=no
--disable-stripping
--enable-const
--enable-ext-colors
--enable-ext-mouse
--enable-overwrite
--enable-pc-files
--enable-widec
--mandir=$MININIX_PREFIX/share/man
--without-ada
--without-cxx-binding
--without-debug
--without-normal
--without-static
--without-tests
--with-shared
"
MININIX_PKG_INCLUDE_IN_DEVPACKAGE="
share/man/man1/ncursesw6-config.1*
bin/ncursesw6-config
"
MININIX_PKG_RM_AFTER_INSTALL="
bin/captoinfo
bin/infotocap
share/man/man1/captoinfo.1*
share/man/man1/infotocap.1*
share/man/man5
share/man/man7
"

mininix_step_pre_configure() {
	MININIX_PKG_EXTRA_CONFIGURE_ARGS+=" --with-pkg-config-libdir=$PKG_CONFIG_LIBDIR"
}

mininix_step_post_make_install () {
	cd $MININIX_PREFIX/lib
	# we need the rm as we create(d) symlinks for the versioned so as well
	for lib in form menu ncurses panel; do
		rm -f lib${lib}.so*
		for file in lib${lib}w.so*; do
			ln -s $file ${file/w./.}
		done
		(cd pkgconfig; ln -sf ${lib}w.pc $lib.pc)
	done
	# some packages want libcurses while building/compiling
	rm -f libcurses.so*
	for file in libncurses.so*; do
		ln -s $file ${file/libn/lib}
	done

	# Some packages want these:
	cd $MININIX_PREFIX/include/
	rm -Rf ncurses{,w}
	mkdir ncurses{,w}
	ln -s ../{ncurses.h,termcap.h,panel.h,unctrl.h,menu.h,form.h,tic.h,nc_tparm.h,term.h,eti.h,term_entry.h,ncurses_dll.h,curses.h} ncurses
	ln -s ../{ncurses.h,termcap.h,panel.h,unctrl.h,menu.h,form.h,tic.h,nc_tparm.h,term.h,eti.h,term_entry.h,ncurses_dll.h,curses.h} ncursesw
}

mininix_step_post_massage () {
	# Strip away 30 years of cruft to decrease size.
	local TI=$MININIX_PKG_MASSAGEDIR/$MININIX_PREFIX/share/terminfo
	mv $TI $MININIX_PKG_TMPDIR/full-terminfo
	mkdir -p $TI/{a,d,e,n,l,p,r,s,t,v,x}
	cp $MININIX_PKG_TMPDIR/full-terminfo/a/ansi $TI/a/
	cp $MININIX_PKG_TMPDIR/full-terminfo/d/{dtterm,dumb} $TI/d/
	cp $MININIX_PKG_TMPDIR/full-terminfo/e/eterm-color $TI/e/
	cp $MININIX_PKG_TMPDIR/full-terminfo/n/nsterm $TI/n/
	cp $MININIX_PKG_TMPDIR/full-terminfo/l/linux $TI/l/
	cp $MININIX_PKG_TMPDIR/full-terminfo/p/putty{,-256color} $TI/p/
	cp $MININIX_PKG_TMPDIR/full-terminfo/r/rxvt{,-256color} $TI/r/
	cp $MININIX_PKG_TMPDIR/full-terminfo/s/screen{,2,-256color} $TI/s/
	cp $MININIX_PKG_TMPDIR/full-terminfo/t/tmux{,-256color} $TI/t/
	cp $MININIX_PKG_TMPDIR/full-terminfo/v/{vt52,vt100,vt102} $TI/v/
	cp $MININIX_PKG_TMPDIR/full-terminfo/x/xterm{,-color,-new,-16color,-256color,+256color} $TI/x/

	tic -x -o $TI $MININIX_PKG_SRCDIR/rxvt-unicode-${MININIX_PKG_VERSION[1]}/doc/etc/rxvt-unicode.terminfo
}

LINUXDROID_PKG_HOMEPAGE=https://www.archlinux.org/pacman/
LINUXDROID_PKG_DESCRIPTION="A library-based package manager with dependency support"
LINUXDROID_PKG_MAINTAINER="Francisco Demartino @franciscod"
# HEAVILY adapted from archlinux PKGBUILD
pkgname=pacman
pkgver=4.2.1
LINUXDROID_PKG_VERSION=$pkgver
#FIXME: asciidoc, fakechroot/fakeroot
LINUXDROID_PKG_DEPENDS="bash, glib, libarchive, curl, gpgme, python2, libandroid-glob, libandroid-support"
LINUXDROID_PKG_SRCURL="https://sources.archlinux.org/other/pacman/$pkgname-$pkgver.tar.gz"
LINUXDROID_PKG_BUILD_IN_SRC=yes
LINUXDROID_PKG_EXTRA_CONFIGURE_ARGS="--prefix=$LINUXDROID_PREFIX --sysconfdir=$LINUXDROID_PREFIX/etc"
LINUXDROID_PKG_EXTRA_CONFIGURE_ARGS+=" --localstatedir=$LINUXDROID_PREFIX/var --enable-doc "
LINUXDROID_PKG_EXTRA_CONFIGURE_ARGS+=" --with-scriptlet-shell=/usr/bin/bash"

linuxdroid_step_pre_configure() {
  LDFLAGS+="$LDFLAGS -llog -landroid-glob"
}

linuxdroid_step_make () {
  make
  make -C contrib
  # make -C "$pkgname-$pkgver" check
}

linuxdroid_step_make_install () {

  make install
  make -C contrib install

  # install Arch specific stuff
  install -dm755 "$LINUXDROID_PREFIX/etc"
  install -m644 "$LINUXDROID_PKG_BUILDER_DIR/pacman.conf" "$LINUXDROID_PREFIX/etc/pacman.conf"

  case $LINUXDROID_ARCH in
    i686)
      mycarch="i686"
      mychost="i686-pc-linux-gnu"
      myflags="-march=i686"
      ;;
    arm)
      mycarch="arm"
      mychost="arm-unknown-linux-gnu"
      myflags="-march=arm"
      ;;
  esac

  # set things correctly in the default conf file
  install -m644 "$LINUXDROID_PKG_BUILDER_DIR/makepkg.conf" "$LINUXDROID_PREFIX/etc"
  sed -i "$LINUXDROID_PREFIX/etc/makepkg.conf" \
    -e "s|@CARCH[@]|$mycarch|g" \
    -e "s|@CHOST[@]|$mychost|g" \
    -e "s|@CARCHFLAGS[@]|$myflags|g"

  # FIXME bash_completion
  # # put bash_completion in the right location
  # install -dm755 "$LINUXDROID_PREFIX/share/bash-completion/completions"
  # mv "$LINUXDROID_PREFIX/etc/bash_completion.d/pacman" "$LINUXDROID_PREFIX/share/bash-completion/completions"
  # rmdir "$LINUXDROID_PREFIX/etc/bash_completion.d"

  # for f in makepkg pacman-key; do
  #   ln -s pacman "$LINUXDROID_PREFIX/share/bash-completion/completions/$f"
  # done

  install -Dm644 contrib/PKGBUILD.vim "$LINUXDROID_PREFIX/share/vim/vimfiles/syntax/PKGBUILD.vim"
}

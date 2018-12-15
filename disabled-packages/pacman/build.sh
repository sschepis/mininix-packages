MININIX_PKG_HOMEPAGE=https://www.archlinux.org/pacman/
MININIX_PKG_DESCRIPTION="A library-based package manager with dependency support"
MININIX_PKG_MAINTAINER="Francisco Demartino @franciscod"
# HEAVILY adapted from archlinux PKGBUILD
pkgname=pacman
pkgver=4.2.1
MININIX_PKG_VERSION=$pkgver
#FIXME: asciidoc, fakechroot/fakeroot
MININIX_PKG_DEPENDS="bash, glib, libarchive, curl, gpgme, python2, libandroid-glob, libandroid-support"
MININIX_PKG_SRCURL="https://sources.archlinux.org/other/pacman/$pkgname-$pkgver.tar.gz"
MININIX_PKG_BUILD_IN_SRC=yes
MININIX_PKG_EXTRA_CONFIGURE_ARGS="--prefix=$MININIX_PREFIX --sysconfdir=$MININIX_PREFIX/etc"
MININIX_PKG_EXTRA_CONFIGURE_ARGS+=" --localstatedir=$MININIX_PREFIX/var --enable-doc "
MININIX_PKG_EXTRA_CONFIGURE_ARGS+=" --with-scriptlet-shell=/usr/bin/bash"

mininix_step_pre_configure() {
  LDFLAGS+="$LDFLAGS -llog -landroid-glob"
}

mininix_step_make () {
  make
  make -C contrib
  # make -C "$pkgname-$pkgver" check
}

mininix_step_make_install () {

  make install
  make -C contrib install

  # install Arch specific stuff
  install -dm755 "$MININIX_PREFIX/etc"
  install -m644 "$MININIX_PKG_BUILDER_DIR/pacman.conf" "$MININIX_PREFIX/etc/pacman.conf"

  case $MININIX_ARCH in
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
  install -m644 "$MININIX_PKG_BUILDER_DIR/makepkg.conf" "$MININIX_PREFIX/etc"
  sed -i "$MININIX_PREFIX/etc/makepkg.conf" \
    -e "s|@CARCH[@]|$mycarch|g" \
    -e "s|@CHOST[@]|$mychost|g" \
    -e "s|@CARCHFLAGS[@]|$myflags|g"

  # FIXME bash_completion
  # # put bash_completion in the right location
  # install -dm755 "$MININIX_PREFIX/share/bash-completion/completions"
  # mv "$MININIX_PREFIX/etc/bash_completion.d/pacman" "$MININIX_PREFIX/share/bash-completion/completions"
  # rmdir "$MININIX_PREFIX/etc/bash_completion.d"

  # for f in makepkg pacman-key; do
  #   ln -s pacman "$MININIX_PREFIX/share/bash-completion/completions/$f"
  # done

  install -Dm644 contrib/PKGBUILD.vim "$MININIX_PREFIX/share/vim/vimfiles/syntax/PKGBUILD.vim"
}

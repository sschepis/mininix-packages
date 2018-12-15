MININIX_PKG_HOMEPAGE=http://remarque.org/~grabiner/moria.html
MININIX_PKG_DESCRIPTION="Rogue-like game with an infinite dungeon"
MININIX_PKG_VERSION=5.6
MININIX_PKG_MAINTAINER="Oliver Schmidhauser @Neo-Oli"
# This seems to be a pretty good mirror
MININIX_PKG_SRCURL=https://github.com/HunterZ/umoria/archive/${MININIX_PKG_VERSION}.tar.gz
MININIX_PKG_SHA256=1ee52ec001539945139b2960e8441f490d2b7f5fe6dce5a070686a178515d182
MININIX_PKG_DEPENDS="ncurses"
MININIX_PKG_BUILD_IN_SRC=yes

mininix_step_pre_configure() {
    ln -s $MININIX_PKG_SRCDIR/source/* $MININIX_PKG_SRCDIR/
    ln -s $MININIX_PKG_SRCDIR/unix/* $MININIX_PKG_SRCDIR/
    mkdir -p $MININIX_PREFIX/share/man/man6/
    cp $MININIX_PKG_SRCDIR/doc/moria.man $MININIX_PREFIX/share/man/man6/moria.6
}
mininix_step_create_debscripts () {
    # Create scores file in a debscript, so an update to the package wouldn't erease any scores
    echo "mkdir -p $MININIX_PREFIX/var/games/moria/" > postinst
    echo "touch $MININIX_PREFIX/var/games/moria/scores" >> postinst
    chmod 0755 postinst

}

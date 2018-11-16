LINUXDROID_PKG_HOMEPAGE=http://remarque.org/~grabiner/moria.html
LINUXDROID_PKG_DESCRIPTION="Rogue-like game with an infinite dungeon"
LINUXDROID_PKG_VERSION=5.6
LINUXDROID_PKG_MAINTAINER="Oliver Schmidhauser @Neo-Oli"
# This seems to be a pretty good mirror
LINUXDROID_PKG_SRCURL=https://github.com/HunterZ/umoria/archive/${LINUXDROID_PKG_VERSION}.tar.gz
LINUXDROID_PKG_SHA256=1ee52ec001539945139b2960e8441f490d2b7f5fe6dce5a070686a178515d182
LINUXDROID_PKG_DEPENDS="ncurses"
LINUXDROID_PKG_BUILD_IN_SRC=yes

linuxdroid_step_pre_configure() {
    ln -s $LINUXDROID_PKG_SRCDIR/source/* $LINUXDROID_PKG_SRCDIR/
    ln -s $LINUXDROID_PKG_SRCDIR/unix/* $LINUXDROID_PKG_SRCDIR/
    mkdir -p $LINUXDROID_PREFIX/share/man/man6/
    cp $LINUXDROID_PKG_SRCDIR/doc/moria.man $LINUXDROID_PREFIX/share/man/man6/moria.6
}
linuxdroid_step_create_debscripts () {
    # Create scores file in a debscript, so an update to the package wouldn't erease any scores
    echo "mkdir -p $LINUXDROID_PREFIX/var/games/moria/" > postinst
    echo "touch $LINUXDROID_PREFIX/var/games/moria/scores" >> postinst
    chmod 0755 postinst

}

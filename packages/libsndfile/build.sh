MININIX_PKG_HOMEPAGE=http://www.mega-nerd.com/libsndfile
MININIX_PKG_DESCRIPTION="Library for reading/writing audio files"
# Use a git master snapshot until 1.0.29 is released:
MININIX_PKG_VERSION=1.0.29~pre1
MININIX_PKG_REVISION=2
MININIX_PKG_SRCURL=https://github.com/erikd/libsndfile/archive/826d5296da54c016e3cb0f7f00de3b9e295b9c4a.zip
MININIX_PKG_SHA256=84651201a8468c448f1fd172a48ccf47f3761d23fd0f59bcaaf908050e9eeb7c
MININIX_PKG_DEPENDS="libflac, libvorbis"
MININIX_PKG_EXTRA_CONFIGURE_ARGS="--disable-sqlite --disable-alsa"
MININIX_PKG_RM_AFTER_INSTALL="bin/ share/man/man1/"

mininix_step_pre_configure () {
	sh autogen.sh
}

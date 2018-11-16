LINUXDROID_PKG_HOMEPAGE=https://github.com/dgoulet/torsocks
LINUXDROID_PKG_DESCRIPTION="Wrapper to safely torify applications"
LINUXDROID_PKG_VERSION=2.2.0.2017.1.17
__TORSOCKS_REF=87b075dd16c675606adee792ef1e22691c51475b
LINUXDROID_PKG_SRCURL=https://github.com/dgoulet/torsocks/archive/${__TORSOCKS_REF}.tar.gz
LINUXDROID_PKG_SHA256=61302919dee9b909f36288d7b2759c74885f7edb06a860a398b8791716d3fda1
LINUXDROID_PKG_DEPENDS="tor"

linuxdroid_step_pre_configure () {
	./autogen.sh
}


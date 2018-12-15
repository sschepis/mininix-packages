# patches taken from https://github.com/michaelwu/alsa-lib
MININIX_PKG_HOMEPAGE=http://www.alsa-project.org
MININIX_PKG_VERSION=1.1.3
# MININIX_PKG_DEPENDS="libandroid-shmem, python2"
MININIX_PKG_DEPENDS="libandroid-shmem"
MININIX_PKG_SRCURL=ftp://ftp.alsa-project.org/pub/lib/alsa-lib-$MININIX_PKG_VERSION.tar.bz2
MININIX_PKG_SHA256=71282502184c592c1a008e256c22ed0ba5728ca65e05273ceb480c70f515969c
# MININIX_PKG_EXTRA_CONFIGURE_ARGS="--with-pythonlibs=\"-lpython2.7\" --with-pythonincludes=-I/$MININIX_PREFIX/include/python2.7"
MININIX_PKG_EXTRA_CONFIGURE_ARGS="--disable-python"

mininix_step_pre_configure () {
    #LDFLAGS="$LDFLAGS -landroid-shmem"
    #_files='src/pcm/pcm_dsnoop.c src/pcm/pcm_mmap.c src/pcm/pcm_shm.c src/pcm/pcm_dmix.c src/pcm/pcm_dshare.c src/pcm/pcm_direct.c src/shmarea.c src/control/control_shm.c aserver/aserver.c'
    #for _file in $_files; do sed -i 's%#include <sys/shm.h>%#include <shmem/shm.h>%' "$MININIX_PKG_SRCDIR/$_file"; done
    #export ac_cv_header_sys_shm_h='no'
    CPPFLAGS="$CPPFLAGS -DMININIX_SHMEM_STUBS -DMININIX_SEMOPS_STUBS"
}

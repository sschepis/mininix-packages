LINUXDROID_NDK_VERSION=18
LINUXDROID_ANDROID_BUILD_TOOLS_VERSION=28.0.2

test -f "$HOME/.linuxdroidrc" && . "$HOME/.linuxdroidrc"

: "${ANDROID_HOME:="${HOME}/lib/android-sdk"}"
: "${NDK:="${HOME}/lib/android-ndk"}"

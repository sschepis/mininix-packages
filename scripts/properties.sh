MININIX_NDK_VERSION=18
MININIX_ANDROID_BUILD_TOOLS_VERSION=28.0.2

test -f "$HOME/.mininixrc" && . "$HOME/.mininixrc"

: "${ANDROID_HOME:="${HOME}/lib/android-sdk"}"
: "${NDK:="${HOME}/lib/android-ndk"}"

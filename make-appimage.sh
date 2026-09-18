#!/bin/sh

set -eu

ARCH=$(uname -m)
export ARCH
export OUTPATH=./dist
export ADD_HOOKS="self-updater.hook"
export UPINFO="gh-releases-zsync|${GITHUB_REPOSITORY%/*}|${GITHUB_REPOSITORY#*/}|latest|*$ARCH.AppImage.zsync"
export ICON=/usr/share/icons/hicolor/scalable/apps/com.github.wwmm.easyeffects.svg
export DESKTOP=/usr/share/applications/com.github.wwmm.easyeffects.desktop
export DEPLOY_QT=1
export DEPLOY_PIPEWIRE=1
export DEPLOY_QML=1
export PATH_MAPPING='
  /usr/lib/lv2:${SHARUN_DIR}/lib/lv2
'

# Deploy dependencies
quick-sharun \
  /usr/lib/calf \
  /usr/bin/easyeffects  \
  /usr/lib/lv2/calf.lv2 \
  /usr/lib/libebur128.so* \
  /usr/lib/librnnoise.so* \
  /usr/lib/lv2/fat1.lv2/  \
  /usr/lib/libspeexdsp.so* \
  /usr/lib/libSoundTouch.so* \
  /usr/lib/lv2/ZaMaximX2.lv2/  \
  /usr/lib/lv2/lsp-plugins.lv2/ \
  /usr/lib/libzita-convolver.so* \
  /usr/lib/lv2/mda.lv2/Bandisto.so \
  /usr/lib/ladspa/libdeep_filter_ladspa.so \
  /usr/lib/libKirigamiFormsPrivateCards.so* \
  /usr/lib/lv2/lsp-plugins.lv2/para_equalizer_x32_ms.ttl 

# Additional changes can be done in between here

# Turn AppDir into AppImage
quick-sharun --make-appimage

# Test the app for 12 seconds, if the test fails due to the app
# having issues running in the CI use --simple-test instead
quick-sharun --simple-test ./dist/*.AppImage

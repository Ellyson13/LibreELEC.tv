################################################################################
#      This file is part of LibreELEC - http://www.libreelec.tv
#      Copyright (C) 2016 Team LibreELEC
#
#  LibreELEC is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 2 of the License, or
#  (at your option) any later version.
#
#  LibreELEC is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with LibreELEC.  If not, see <http://www.gnu.org/licenses/>.
################################################################################

PKG_NAME="fs-uae"
PKG_VERSION="3155eea"
PKG_ARCH="any"
PKG_LICENSE="GPLv3"
PKG_SITE="https://github.com/FrodeSolheim/fs-uae"
PKG_URL="https://github.com/FrodeSolheim/fs-uae/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain SDL2 glew glu libmpeg2 libXi openal-soft"
PKG_SECTION="emulation"
PKG_SHORTDESC="FS-UAE amiga emulator."

PKG_IS_ADDON="no"
PKG_AUTORECONF="yes"

pre_configure_target() {
  export ac_cv_func_realloc_0_nonnull=yes
  export SYSROOT_PREFIX
  cp $PKG_DIR/input/* ../share/fs-uae/input/
}

post_makeinstall_target() {
  # install scripts
  cp $PKG_DIR/scripts/* $INSTALL/usr/bin/

  # set up default config directory
  mkdir -p $INSTALL/usr/config
  cp -R $PKG_DIR/config $INSTALL/usr/config/fs-uae
  ln -s /storage/roms/bios $INSTALL/usr/config/fs-uae/Kickstarts

  # install capsimg plugin for ipf support
  mkdir -p $INSTALL/usr/config/fs-uae/Plugins
  wget https://fs-uae.net/devel/plugins/CAPSImg/CAPSImg_5.1fs3.zip
  unzip -o -d $INSTALL/usr/config/fs-uae/Plugins CAPSImg_5.1fs3.zip
  rm -rf $INSTALL/usr/config/fs-uae/Plugins/CAPSImg/macOS
  rm -rf $INSTALL/usr/config/fs-uae/Plugins/CAPSImg/Windows
  rm -rf $INSTALL/usr/config/fs-uae/Plugins/CAPSImg/Linux/x86

  rm -rf $INSTALL/usr/share/applications
  rm -rf $INSTALL/usr/share/icons
  rm -rf $INSTALL/usr/share/mime
}

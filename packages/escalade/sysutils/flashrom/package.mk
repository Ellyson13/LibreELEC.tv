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

PKG_NAME="flashrom"
PKG_VERSION="0.9.9"
PKG_ARCH="x86_64"
PKG_LICENSE="GPL"
PKG_SITE="http://www.flashrom.org"
PKG_URL="http://download.flashrom.org/releases/$PKG_NAME-$PKG_VERSION.tar.bz2"
PKG_DEPENDS_TARGET="toolchain zlib pciutils libftdi1"
PKG_PRIORITY="optional"
PKG_SECTION="tools"
PKG_SHORTDESC="flashrom: linux BIOS programmer"
PKG_LONGDESC="flashrom is a utility for identifying, reading, writing, verifying and erasing flash chips. It is designed to flash BIOS/EFI/coreboot/firmware/optionROM images on mainboards, network/graphics/storage controller cards, and various programmer devices."

PKG_AUTORECONF="no"

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="xbmc.python.script"
PKG_ADDON_PROVIDES=""
PKG_ADDON_REPOVERSION="8.0"

PKG_MAKE_OPTS_TARGET="CC=$CC STRIP=$STRIP PREFIX=/usr WARNERROR=no CONFIG_ENABLE_LIBUSB0_PROGRAMMERS=no"
PKG_MAKEINSTALL_OPTS_TARGET="CC=$CC STRIP=$STRIP PREFIX=/usr WARNERROR=no"

pre_make_target() {
  export LDFLAGS="$LDFLAGS -ludev -lkmod"
}

make_target() {
  make CC=$CC
}

addon() {
  mkdir -p $ADDON_BUILD/$PKG_ADDON_ID/bin
    cp -PR $PKG_BUILD/flashrom $ADDON_BUILD/$PKG_ADDON_ID/bin
}

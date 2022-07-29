################################################################################
#
# openjpeg
#
################################################################################

OPENJPEG_VERSION = 2.5.0
OPENJPEG_SITE = $(call github,uclouvain,openjpeg,v$(OPENJPEG_VERSION))
OPENJPEG_LICENSE = BSD-2-Clause
OPENJPEG_LICENSE_FILES = LICENSE
OPENJPEG_CPE_ID_VENDOR = uclouvain
OPENJPEG_INSTALL_STAGING = YES

OPENJPEG_DEPENDENCIES += $(if $(BR2_PACKAGE_ZLIB),zlib)
OPENJPEG_DEPENDENCIES += $(if $(BR2_PACKAGE_LIBPNG),libpng)
OPENJPEG_DEPENDENCIES += $(if $(BR2_PACKAGE_TIFF),tiff)
OPENJPEG_DEPENDENCIES += $(if $(BR2_PACKAGE_LCMS2),lcms2)

ifeq ($(BR2_PREFER_USR_LOCAL),y)
OPENJPEG_CONFIGURE_PREFIX=/usr/local
OPENJPEG_CONFIGURE_EXEC_PREFIX=/usr/local

define OPENJPEG_FIX_INSTALL_LOCATIONS
	rm -rf $(TARGET_DIR)/usr/include
	rm -rf $(TARGET_DIR)/usr/lib/pkgconfig
	rm -rf $(TARGET_DIR)/usr/lib/openjpeg-*
	mv -f $(TARGET_DIR)/usr/lib/libopenjp2.* $(TARGET_DIR)/usr/local/lib
	mv -f $(TARGET_DIR)/usr/bin/opj_* $(TARGET_DIR)/usr/local/bin
endef

OPENJPEG_POST_INSTALL_TARGET_HOOKS += OPENJPEG_FIX_INSTALL_LOCATIONS
endif


ifeq ($(BR2_TOOLCHAIN_HAS_THREADS),y)
OPENJPEG_CONF_OPTS += -DOPJ_USE_THREAD=ON
else
OPENJPEG_CONF_OPTS += -DOPJ_USE_THREAD=OFF
endif

$(eval $(cmake-package))

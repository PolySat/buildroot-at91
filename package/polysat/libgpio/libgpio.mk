#############################################################
#
# Polysat libgpio
#
#############################################################
LIBGPIO_SITE:=git@github.com:PolySat/libgpio.git
LIBGPIO_SITE_METHOD:=git
LIBGPIO_INSTALL_TARGET=YES
LIBGPIO_INSTALL_STAGING=YES

ifeq ($(BR2_PACKAGE_LIBGPIO_version_custom),y)
   LIBGPIO_VERSION=$(subst ",,$(BR2_PACKAGE_LIBGPIO_CONFIG_CUSTOM_VERSION_STR))
endif

ifeq ($(BR2_PACKAGE_LIBGPIO_version_head),y)
   LIBGPIO_VERSION:=$(shell git ls-remote $(LIBGPIO_SITE) | grep HEAD | head -1 | sed -e 's/[ \t]*HEAD//')
endif

ifeq ($(BR2_PACKAGE_LIBGPIO_version_1),y)
   LIBGPIO_VERSION:=v1.0
endif

ifeq ($(BR2_PACKAGE_LIBGPIO),y)
   LIBGPIO_VERSION?=$(shell git ls-remote $(LIBGPIO_SITE) | grep HEAD | head -1 | sed -e 's/[ \t]*HEAD//')
else
   LIBGPIO_VERSION?=v1.0
endif

define LIBGPIO_BUILD_CMDS
 $(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(@D)
endef

define HOST_LIBGPIO_BUILD_CMDS
 $(MAKE1) -C $(@D)
endef

define LIBGPIO_INSTALL_STAGING_CMDS
   $(MAKE) -C $(@D) INC_PATH=$(STAGING_DIR)/usr/include LIB_PATH=$(STAGING_DIR)/usr/lib BIN_PATH=$(TARGET_DIR)/usr/bin SBIN_PATH=$(TARGET_DIR)/usr/sbin install
endef

define LIBGPIO_INSTALL_TARGET_CMDS
   $(MAKE) -C $(@D) INC_PATH=$(STAGING_DIR)/usr/include LIB_PATH=$(TARGET_DIR)/usr/lib BIN_PATH=$(TARGET_DIR)/usr/bin SBIN_PATH=$(TARGET_DIR)/usr/sbin install
endef

define HOST_LIBGPIO_INSTALL_CMDS
   $(MAKE1) -C $(@D) INC_PATH=$(HOST_DIR)/usr/include LIB_PATH=$(HOST_DIR)/usr/lib BIN_PATH=$(HOST_DIR)/usr/bin SBIN_PATH=$(HOST_DIR)/usr/sbin install
   $(HOST_DIR)/bin/patchelf --set-rpath "$(HOST_DIR)/lib" $(HOST_DIR)/bin/gpiotest
endef

$(eval $(generic-package))
$(eval $(host-generic-package))

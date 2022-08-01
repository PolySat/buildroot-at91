#############################################################
#
# Polysat Proclib
#
#############################################################
LIBPROC_SITE:=https://github.com/PolySat/libproc.git
LIBPROC_SITE_METHOD:=git
LIBPROC_INSTALL_STAGING=YES
LIBPROC_INSTALL_TARGET=YES
LIBPROC_DEPENDENCIES=host-polyxdr
HOST_LIBPROC_DEPENDENCIES=host-polyxdr

ifeq ($(BR2_PACKAGE_LIBPROC_version_custom),y)
   LIBPROC_VERSION:=$(subst ",,$(BR2_PACKAGE_LIBPROC_CONFIG_CUSTOM_VERSION_STR))
endif

ifeq ($(BR2_PACKAGE_LIBPROC_version_head),y)
   LIBPROC_VERSION:=$(shell git ls-remote $(LIBPROC_SITE) | grep HEAD | head -1 | sed -e 's/[ \t]*HEAD//')
endif

ifeq ($(BR2_PACKAGE_LIBPROC),y)
   LIBPROC_VERSION?=$(shell git ls-remote $(LIBPROC_SITE) | grep HEAD | head -1 | sed -e 's/[ \t]*HEAD//')
else
   LIBPROC_VERSION?=HEAD
endif

define LIBPROC_BUILD_CMDS
 $(MAKE) $(TARGET_CONFIGURE_OPTS) XDRGEN=$(HOST_DIR)/usr/bin/poly-xdrgen -C $(@D)
endef

define HOST_LIBPROC_BUILD_CMDS
 $(MAKE1) XDRGEN=$(HOST_DIR)/usr/bin/poly-xdrgen -C $(@D)
endef

ifeq ($(BR2_PACKAGE_POLYSAT_BINARIES),y)

define LIBPROC_INSTALL_STAGING_CMDS
   $(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(@D) INC_PATH=$(STAGING_DIR)/usr/include LIB_PATH=$(STAGING_DIR)/usr/lib install
   $(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(@D) INC_PATH=$(BINSTAGING_DIR)/usr/include LIB_PATH=$(BINSTAGING_DIR)/usr/lib install
endef

define LIBPROC_INSTALL_TARGET_CMDS
   $(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(@D) INC_PATH=$(STAGING_DIR)/usr/include LIB_PATH=$(TARGET_DIR)/usr/lib install
   $(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(@D) INC_PATH=$(BINSTAGING_DIR)/usr/include LIB_PATH=$(BINTARGET_DIR)/usr/lib install
endef

define HOST_LIBPROC_INSTALL_CMDS
   $(MAKE1) -C $(@D) INC_PATH=$(HOST_DIR)/usr/include LIB_PATH=$(HOST_DIR)/usr/lib install
   $(MAKE1) -C $(@D) INC_PATH=$(BINHOST_DIR)/usr/include LIB_PATH=$(BINHOST_DIR)/usr/lib install
endef

else

define LIBPROC_INSTALL_STAGING_CMDS
   $(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(@D) INC_PATH=$(STAGING_DIR)/usr/include LIB_PATH=$(STAGING_DIR)/usr/lib install
endef

define LIBPROC_INSTALL_TARGET_CMDS
   $(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(@D) INC_PATH=$(STAGING_DIR)/usr/include LIB_PATH=$(TARGET_DIR)/usr/lib install
endef

define HOST_LIBPROC_INSTALL_CMDS
   $(MAKE1) -C $(@D) INC_PATH=$(HOST_DIR)/usr/include LIB_PATH=$(HOST_DIR)/usr/lib install
endef

endif

$(eval $(generic-package))
$(eval $(host-generic-package))

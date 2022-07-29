################################################################################
#
# picocom
#
################################################################################

PICOCOM_VERSION = 3.1
PICOCOM_SITE = $(call github,npat-efault,picocom,$(PICOCOM_VERSION))
PICOCOM_LICENSE = GPL-2.0+
PICOCOM_LICENSE_FILES = LICENSE.txt
PICOCOM_CPE_ID_VENDOR = picocom_project
PICOCOM_TARGET_DEST=usr/bin/picocom

ifeq ($(BR2_PREFER_USR_LOCAL),y)
PICOCOM_TARGET_DEST=usr/local/bin/picocom
endif

define PICOCOM_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) -C $(@D)
endef

define PICOCOM_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0755 $(@D)/picocom $(TARGET_DIR)/$(PICOCOM_TARGET_DEST)
endef

$(eval $(generic-package))

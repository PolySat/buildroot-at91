################################################################################
#
# lzo
#
################################################################################

LZO_VERSION = 2.10
LZO_SITE = http://www.oberhumer.com/opensource/lzo/download
LZO_LICENSE = GPL-2.0+
LZO_LICENSE_FILES = COPYING
LZO_CPE_ID_VENDOR = lzo_project
LZO_INSTALL_STAGING = YES
LZO_SUPPORTS_IN_SOURCE_BUILD = NO

ifeq ($(BR2_PREFER_USR_LOCAL),y)
LZO_CONFIGURE_PREFIX=/usr/local
LZO_CONFIGURE_EXEC_PREFIX=/usr/local
LZO_POST_INSTALL_TARGET_HOOKS+=LZO_CLEAN_STATIC_LIBS

define LZO_CLEAN_STATIC_LIBS
	rm -f $(addprefix $(TARGET_DIR)/usr/local/lib/,liblzo2.a liblzo2.la)
endef
endif

ifeq ($(BR2_SHARED_LIBS)$(BR2_SHARED_STATIC_LIBS),y)
LZO_CONF_OPTS += -DENABLE_SHARED=ON
else
LZO_CONF_OPTS += -DENABLE_SHARED=OFF
endif

ifeq ($(BR2_STATIC_LIBS)$(BR2_SHARED_STATIC_LIBS),y)
LZO_CONF_OPTS += -DENABLE_STATIC=ON
else
LZO_CONF_OPTS += -DENABLE_STATIC=OFF
endif

HOST_LZO_CONF_OPTS += -DENABLE_SHARED=ON -DENABLE_STATIC=OFF

$(eval $(cmake-package))
$(eval $(host-cmake-package))

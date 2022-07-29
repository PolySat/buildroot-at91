################################################################################
#
# libpng
#
################################################################################

LIBPNG_VERSION = 1.6.37
LIBPNG_SERIES = 16
LIBPNG_SOURCE = libpng-$(LIBPNG_VERSION).tar.xz
LIBPNG_SITE = http://downloads.sourceforge.net/project/libpng/libpng$(LIBPNG_SERIES)/$(LIBPNG_VERSION)
LIBPNG_LICENSE = Libpng-2.0
LIBPNG_LICENSE_FILES = LICENSE
LIBPNG_CPE_ID_VENDOR = libpng
LIBPNG_INSTALL_STAGING = YES
LIBPNG_DEPENDENCIES = host-pkgconf zlib
HOST_LIBPNG_DEPENDENCIES = host-pkgconf host-zlib

ifeq ($(BR2_ARM_CPU_HAS_NEON)$(BR2_aarch64),y)
LIBPNG_CONF_OPTS += --enable-arm-neon
else
LIBPNG_CONF_OPTS += --disable-arm-neon
endif

ifeq ($(BR2_X86_CPU_HAS_SSE2),y)
LIBPNG_CONF_OPTS += --enable-intel-sse
else
LIBPNG_CONF_OPTS += --disable-intel-sse
endif

ifeq ($(BR2_PREFER_USR_LOCAL),y)
LIBPNG_LOCAL_CONFIG_SCRIPTS = libpng$(LIBPNG_SERIES)-config libpng-config
LIBPNG_CONFIGURE_PREFIX=/usr/local
LIBPNG_CONFIGURE_EXEC_PREFIX=/usr/local

define LIBPNG_STAGING_LIBPNG12_CONFIG_FIXUP
        $(SED) "s,^prefix=.*,prefix=\'$(STAGING_DIR)/usr/local\',g" \
                -e "s,^exec_prefix=.*,exec_prefix=\'$(STAGING_DIR)/usr/local\',g" \
                -e "s,^includedir=.*,includedir=\'$(STAGING_DIR)/usr/local/include/libpng$(LIBPNG_SERIES)\',g" \
                -e "s,^libdir=.*,libdir=\'$(STAGING_DIR)/usr/local/lib\',g" \
                $(STAGING_DIR)/usr/local/bin/libpng$(LIBPNG_SERIES)-config
endef

LIBPNG_POST_INSTALL_STAGING_HOOKS += LIBPNG_STAGING_LIBPNG12_CONFIG_FIXUP

define LIBPNG_REMOVE_CONFIG_SCRIPTS
	$(RM) -f $(TARGET_DIR)/usr/local/bin/libpng$(LIBPNG_SERIES)-config \
                 $(TARGET_DIR)/usr/local/bin/libpng-config \
                 $(TARGET_DIR)/usr/local/lib/libpng$(LIBPNG_SERIES).a \
                 $(TARGET_DIR)/usr/local/lib/libpng$(LIBPNG_SERIES).la \
                 $(TARGET_DIR)/usr/local/lib/libpng.la
endef

ifneq ($(BR2_HAVE_DEVFILES),y)
LIBPNG_POST_INSTALL_TARGET_HOOKS += LIBPNG_REMOVE_CONFIG_SCRIPTS
endif
else
LIBPNG_CONFIG_SCRIPTS = libpng$(LIBPNG_SERIES)-config libpng-config
endif

$(eval $(autotools-package))
$(eval $(host-autotools-package))

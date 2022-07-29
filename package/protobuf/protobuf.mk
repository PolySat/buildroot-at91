################################################################################
#
# protobuf
#
################################################################################

# When bumping this package, make sure to also verify if the
# python-protobuf package still works and to update its hash,
# as they share the same version/site variables.
PROTOBUF_VERSION = 3.19.1
PROTOBUF_SOURCE = protobuf-cpp-$(PROTOBUF_VERSION).tar.gz
PROTOBUF_SITE = https://github.com/protocolbuffers/protobuf/releases/download/v$(PROTOBUF_VERSION)
PROTOBUF_LICENSE = BSD-3-Clause
PROTOBUF_LICENSE_FILES = LICENSE
PROTOBUF_CPE_ID_VENDOR = google

ifeq ($(BR2_PREFER_USR_LOCAL),y)
PROTOBUF_CONFIGURE_PREFIX=/usr/local
PROTOBUF_CONFIGURE_EXEC_PREFIX=/usr/local

define PROTOBUF_REMOVE_UNNECESSARY_TARGET_FILES
	rm -rf $(TARGET_DIR)/usr/local/bin/protoc
	rm -rf $(TARGET_DIR)/usr/local/lib/libprotoc.so*
endef

PROTOBUF_POST_INSTALL_TARGET_HOOKS += PROTOBUF_REMOVE_UNNECESSARY_TARGET_FILES
endif

# N.B. Need to use host protoc during cross compilation.
PROTOBUF_DEPENDENCIES = host-protobuf
PROTOBUF_CONF_OPTS = --with-protoc=$(HOST_DIR)/bin/protoc

PROTOBUF_CXXFLAGS = $(TARGET_CXXFLAGS)

ifeq ($(BR2_TOOLCHAIN_HAS_GCC_BUG_85180),y)
PROTOBUF_CXXFLAGS += -O0
endif

ifeq ($(BR2_or1k),y)
PROTOBUF_CXXFLAGS += -mcmodel=large
endif

PROTOBUF_CONF_ENV = CXXFLAGS="$(PROTOBUF_CXXFLAGS)"

ifeq ($(BR2_TOOLCHAIN_HAS_LIBATOMIC),y)
PROTOBUF_CONF_ENV += LIBS=-latomic
endif

PROTOBUF_INSTALL_STAGING = YES

ifeq ($(BR2_PACKAGE_ZLIB),y)
PROTOBUF_DEPENDENCIES += zlib
endif

$(eval $(autotools-package))
$(eval $(host-autotools-package))

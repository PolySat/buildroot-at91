################################################################################
#
# lzop
#
################################################################################

LZOP_VERSION = 1.03
LZOP_SITE = http://www.lzop.org/download
LZOP_LICENSE = GPL-2.0+
LZOP_LICENSE_FILES = COPYING
LZOP_DEPENDENCIES = lzo
HOST_LZOP_DEPENDENCIES = host-lzo

ifeq ($(BR2_PREFER_USR_LOCAL),y)
LZOP_CONFIGURE_PREFIX=/usr/local
LZOP_CONFIGURE_EXEC_PREFIX=/usr/local
endif

$(eval $(autotools-package))
$(eval $(host-autotools-package))

LZOP = $(HOST_DIR)/bin/lzop

################################################################################
#
# lzma
#
################################################################################

LZMA_VERSION = 4.32.7
LZMA_SOURCE = lzma-$(LZMA_VERSION).tar.xz
LZMA_SITE = http://tukaani.org/lzma
LZMA_LICENSE = LGPL-2.1+ (lzmadec library, lzmainfo, LzmaDecode), GPL-2.0+ (lzma program, lzgrep and lzmore scripts), GPL-3.0+ (tests)
LZMA_LICENSE_FILES = COPYING.GPLv2 COPYING.GPLv3 COPYING.LGPLv2.1

ifeq ($(BR2_PREFER_USR_LOCAL),y)
LZMA_CONFIGURE_PREFIX=/usr/local
LZMA_CONFIGURE_EXEC_PREFIX=/usr/local
endif

$(eval $(host-autotools-package))

LZMA = $(HOST_DIR)/bin/lzma

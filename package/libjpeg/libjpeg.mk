################################################################################
#
# libjpeg
#
################################################################################

LIBJPEG_VERSION = 9e
LIBJPEG_SITE = http://www.ijg.org/files
LIBJPEG_SOURCE = jpegsrc.v$(LIBJPEG_VERSION).tar.gz
LIBJPEG_LICENSE = IJG
LIBJPEG_LICENSE_FILES = README
LIBJPEG_INSTALL_STAGING = YES
LIBJPEG_CPE_ID_VENDOR = ijg
LIBJPEG_PROVIDES = jpeg

ifeq ($(BR2_PREFER_USR_LOCAL),y)
JPEG_CONFIGURE_PREFIX=/usr/local
JPEG_CONFIGURE_EXEC_PREFIX=/usr/local

define LIBJPEG_REMOVE_USELESS_TOOLS
	rm -f $(addprefix $(TARGET_DIR)/usr/local/bin/,cjpeg djpeg jpegtran rdjpgcom wrjpgcom)
	rm -f $(addprefix $(TARGET_DIR)/usr/local/lib,libjpeg.a libjpeg.la)
endef
else
define LIBJPEG_REMOVE_USELESS_TOOLS
	rm -f $(addprefix $(TARGET_DIR)/usr/bin/,cjpeg djpeg jpegtran rdjpgcom wrjpgcom)
endef
endif

LIBJPEG_POST_INSTALL_TARGET_HOOKS += LIBJPEG_REMOVE_USELESS_TOOLS

define LIBJPEG_INSTALL_STAGING_PC
	$(INSTALL) -D -m 0644 package/libjpeg/libjpeg.pc.in \
		$(STAGING_DIR)/usr/lib/pkgconfig/libjpeg.pc
	version=`sed -e '/^PACKAGE_VERSION/!d;s/PACKAGE_VERSION = \(.*\)/\1/' $(@D)/Makefile` ; \
		$(SED) "s/@PACKAGE_VERSION@/$${version}/" $(STAGING_DIR)/usr/lib/pkgconfig/libjpeg.pc
endef

LIBJPEG_POST_INSTALL_STAGING_HOOKS += LIBJPEG_INSTALL_STAGING_PC

$(eval $(autotools-package))
$(eval $(host-autotools-package))

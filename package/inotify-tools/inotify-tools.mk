################################################################################
#
# inotify-tools
#
################################################################################

INOTIFY_TOOLS_VERSION = 3.20.2.2
INOTIFY_TOOLS_SITE = https://github.com/inotify-tools/inotify-tools/releases/download/$(INOTIFY_TOOLS_VERSION)
INOTIFY_TOOLS_LICENSE = GPL-2.0+
INOTIFY_TOOLS_LICENSE_FILES = COPYING
INOTIFY_TOOLS_INSTALL_STAGING = YES

ifeq ($(BR2_PREFER_USR_LOCAL),y)
INOTIFY_TOOLS_CONFIGURE_PREFIX=/usr/local
INOTIFY_TOOLS_CONFIGURE_EXEC_PREFIX=/usr/local
INOTIFY_TOOLS_POST_INSTALL_TARGET_HOOKS+=INOTIFY_TOOLS_CLEAN_STATIC_LIBS

define INOTIFY_TOOLS_CLEAN_STATIC_LIBS
        rm -f $(addprefix $(TARGET_DIR)/usr/local/lib/,libinotifytools.a libinotifytools.la)
endef
endif

$(eval $(autotools-package))

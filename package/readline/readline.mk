################################################################################
#
# readline
#
################################################################################

READLINE_VERSION = 8.1.2
READLINE_MAJOR_VERSION = 8.1
READLINE_SITE = $(BR2_GNU_MIRROR)/readline
READLINE_INSTALL_STAGING = YES
READLINE_DEPENDENCIES = ncurses host-autoconf
HOST_READLINE_DEPENDENCIES = host-ncurses host-autoconf
READLINE_CONF_ENV = bash_cv_func_sigsetjmp=yes \
	bash_cv_wcwidth_broken=no
READLINE_CONF_OPTS = --disable-install-examples
READLINE_LICENSE = GPL-3.0+
READLINE_LICENSE_FILES = COPYING
READLINE_CPE_ID_VENDOR = gnu

ifeq ($(BR2_PACKAGE_READLINE_BRACKETED_PASTE),y)
READLINE_CONF_OPTS += --enable-bracketed-paste-default
else
READLINE_CONF_OPTS += --disable-bracketed-paste-default
endif

ifeq ($(BR2_PREFER_USR_LOCAL),y)
READLINE_CONFIGURE_PREFIX=/usr/local
READLINE_CONFIGURE_EXEC_PREFIX=/usr/local

define READLINE_INSTALL_TARGET_CMDS
        $(MAKE1) DESTDIR=$(TARGET_DIR) -C $(@D) uninstall
	$(MAKE1) DESTDIR=$(TARGET_DIR) -C $(@D) install-shared uninstall-doc
	chmod 775 $(TARGET_DIR)/usr/local/lib/libreadline.so.$(READLINE_MAJOR_VERSION) \
		$(TARGET_DIR)/usr/local/lib/libhistory.so.$(READLINE_MAJOR_VERSION)
		$(STRIPCMD) $(STRIP_STRIP_UNNEEDED) \
		$(TARGET_DIR)/usr/local/lib/libreadline.so.$(READLINE_MAJOR_VERSION) \
		$(TARGET_DIR)/usr/local/lib/libhistory.so.$(READLINE_MAJOR_VERSION)
endef
endif

define READLINE_INSTALL_INPUTRC
	$(INSTALL) -D -m 644 package/readline/inputrc $(TARGET_DIR)/etc/inputrc
endef
READLINE_POST_INSTALL_TARGET_HOOKS += READLINE_INSTALL_INPUTRC

$(eval $(autotools-package))
$(eval $(host-autotools-package))

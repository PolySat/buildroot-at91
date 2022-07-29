################################################################################
#
# netcat
#
################################################################################

NETCAT_VERSION = 0.7.1
NETCAT_SITE = http://downloads.sourceforge.net/project/netcat/netcat/$(NETCAT_VERSION)
NETCAT_LICENSE = GPL-2.0+
NETCAT_LICENSE_FILES = COPYING
NETCAT_CPE_ID_VENDOR = netcat_project

ifeq ($(BR2_PREFER_USR_LOCAL),y)
NETCAT_CONFIGURE_PREFIX=/usr/local
NETCAT_CONFIGURE_EXEC_PREFIX=/usr/local
endif

$(eval $(autotools-package))

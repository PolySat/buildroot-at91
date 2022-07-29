################################################################################
#
## python-regex
#
#################################################################################

POLYXDR_VERSION = 1.1
POLYXDR_SOURCE = polyxdr-$(PYTHON_REGEX_VERSION).tar.gz
POLYXDR_SITE = $(call github,PolySat,polyxdr,v$(POLYXDR_VERSION))
POLYXDR_SETUP_TYPE = setuptools
POLYXDR_LICENSE = GPL-2.0
POLYXDR_LICENSE_FILES = LICENSE
	
$(eval $(host-python-package))

################################################################################
#
## python-regex
#
#################################################################################

POLYXDR_VERSION = v1.2
POLYXDR_SITE:=https://github.com/PolySat/polyxdr.git
POLYXDR_SITE_METHOD:=git
POLYXDR_SETUP_TYPE = setuptools
POLYXDR_LICENSE = GPL-2.0
POLYXDR_LICENSE_FILES = LICENSE
POLYXDR_DEPENDENCIES=python-pyparsing
HOST_POLYXDR_DEPENDENCIES=host-python-pyparsing host-python-tenjin

$(eval $(host-python-package))

################################################################################
#
# python-tenjin
#
################################################################################

PYTHON_TENJIN_VERSION = 1.1.1
PYTHON_TENJIN_SOURCE = Tenjin-$(PYTHON_TENJIN_VERSION).tar.gz
PYTHON_TENJIN_SITE = https://files.pythonhosted.org/packages/31/8f/53d4140a5100ce21fef6294ce06be82aa5b7942be27355e532343901eb57
PYTHON_TENJIN_LICENSE = MIT
PYTHON_TENJIN_LICENSE_FILES = LICENSE
PYTHON_TENJIN_SETUP_TYPE = setuptools
PYTHON_SINGLE_MANAGED:=

$(eval $(python-package))
$(eval $(host-python-package))

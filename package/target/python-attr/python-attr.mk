################################################################################
#
# python-attr
#
################################################################################

PYTHON_ATTR_VERSION = 0.1.0
PYTHON_ATTR_DIR = attr-$(PYTHON_ATTR_VERSION)
PYTHON_ATTR_SOURCE = attr-$(PYTHON_ATTR_VERSION).tar.gz
PYTHON_ATTR_SITE = https://pypi.python.org/packages/source/a/attr

$(D)/python-attr: | bootstrap
	$(call python-package)

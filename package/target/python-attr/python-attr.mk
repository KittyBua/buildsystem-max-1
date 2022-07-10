################################################################################
#
# python-attr
#
################################################################################

PYTHON_ATTR_VERSION = 0.1.0
PYTHON_ATTR_DIR = attr-$(PYTHON_ATTR_VERSION)
PYTHON_ATTR_SOURCE = attr-$(PYTHON_ATTR_VERSION).tar.gz
PYTHON_ATTR_SITE = https://pypi.python.org/packages/source/a/attr

PYTHON_ATTR_DEPENDS = python python-setuptools

$(D)/python-attr: | bootstrap
	$(call target-python-package)

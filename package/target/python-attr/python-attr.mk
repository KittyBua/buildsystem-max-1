################################################################################
#
# python-attr
#
################################################################################

PYTHON_ATTR_VERSION = 0.1.0
PYTHON_ATTR_DIR     = attr-$(PYTHON_ATTR_VERSION)
PYTHON_ATTR_SOURCE  = attr-$(PYTHON_ATTR_VERSION).tar.gz
PYTHON_ATTR_SITE    = https://pypi.python.org/packages/source/a/attr
PYTHON_ATTR_DEPENDS = bootstrap python python-setuptools

$(D)/python-attr:
	$(call python-package)

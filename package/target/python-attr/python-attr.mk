#
# python-attr
#
PYTHON_ATTR_VERSION = 0.1.0
PYTHON_ATTR_DIR     = attr-$(PYTHON_ATTR_VERSION)
PYTHON_ATTR_SOURCE  = attr-$(PYTHON_ATTR_VERSION).tar.gz
PYTHON_ATTR_SITE    = https://pypi.python.org/packages/source/a/attr
PYTHON_ATTR_DEPENDS = bootstrap python python-setuptools

python-attr:
	$(START_BUILD)
	$(REMOVE)
	$(call DOWNLOAD,$($(PKG)_SOURCE))
	$(call EXTRACT,$(BUILD_DIR))
	$(APPLY_PATCHES)
	$(CD_BUILD_DIR); \
		$(PYTHON_BUILD); \
		$(PYTHON_INSTALL)
	$(REMOVE)
	$(TOUCH)

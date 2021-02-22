#
# python-attr
#
PYTHON_ATTR_VER    = 0.1.0
PYTHON_ATTR_DIR    = attr-$(PYTHON_ATTR_VER)
PYTHON_ATTR_SOURCE = attr-$(PYTHON_ATTR_VER).tar.gz
PYTHON_ATTR_SITE   = https://pypi.python.org/packages/source/a/attr
PYTHON_ATTR_DEPS   = bootstrap python python-setuptools

$(D)/python-attr:
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

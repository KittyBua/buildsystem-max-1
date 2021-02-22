#
# python-attrs
#
PYTHON_ATTRS_VER    = 16.3.0
PYTHON_ATTRS_DIR    = attrs-$(PYTHON_ATTRS_VER)
PYTHON_ATTRS_SOURCE = attrs-$(PYTHON_ATTRS_VER).tar.gz
PYTHON_ATTRS_SITE   = https://pypi.io/packages/source/a/attrs
PYTHON_ATTRS_DEPS   = bootstrap python python-setuptools

$(D)/python-attrs:
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

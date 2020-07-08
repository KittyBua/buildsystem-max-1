#
# python-attrs
#
PYTHON_ATTRS_VER    = 16.3.0
PYTHON_ATTRS_DIR    = attrs-$(PYTHON_ATTRS_VER)
PYTHON_ATTRS_SOURCE = attrs-$(PYTHON_ATTRS_VER).tar.gz
PYTHON_ATTRS_SITE   = https://pypi.io/packages/source/a/attrs

$(D)/python-attrs: bootstrap python python-setuptools
	$(START_BUILD)
	$(PKG_REMOVE)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(call PKG_UNPACK,$(BUILD_DIR))
	$(PKG_CHDIR); \
		$(PYTHON_BUILD); \
		$(PYTHON_INSTALL)
	$(PKG_REMOVE)
	$(TOUCH)

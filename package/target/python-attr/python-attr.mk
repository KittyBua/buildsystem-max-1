#
# python-attr
#
PYTHON_ATTR_VER    = 0.1.0
PYTHON_ATTR_DIR    = attr-$(PYTHON_ATTR_VER)
PYTHON_ATTR_SOURCE = attr-$(PYTHON_ATTR_VER).tar.gz
PYTHON_ATTR_SITE   = https://pypi.python.org/packages/source/a/attr

$(D)/python-attr: bootstrap python python-setuptools
	$(START_BUILD)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(PKG_REMOVE)
	$(call PKG_UNPACK,$(BUILD_DIR))
	$(PKG_CHDIR); \
		$(PYTHON_BUILD); \
		$(PYTHON_INSTALL)
	$(PKG_REMOVE)
	$(TOUCH)

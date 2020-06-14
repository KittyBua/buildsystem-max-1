#
# python-attrs
#
PYTHON_ATTRS_VER    = 16.3.0
PYTHON_ATTRS_DIR    = attrs-$(PYTHON_ATTRS_VER)
PYTHON_ATTRS_SOURCE = attrs-$(PYTHON_ATTRS_VER).tar.gz
PYTHON_ATTRS_URL    = https://pypi.io/packages/source/a/attrs

$(D)/python-attrs: bootstrap python python-setuptools
	$(START_BUILD)
	$(call DOWNLOAD,$(PKG_SOURCE))
	$(REMOVE)/$(PKG_DIR)
	$(UNTAR)/$(PKG_SOURCE)
	$(CHDIR)/$(PKG_DIR); \
		$(PYTHON_BUILD); \
		$(PYTHON_INSTALL)
	$(REMOVE)/$(PKG_DIR)
	$(TOUCH)

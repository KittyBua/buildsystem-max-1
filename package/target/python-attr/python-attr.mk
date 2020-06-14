#
# python-attr
#
PYTHON_ATTR_VER    = 0.1.0
PYTHON_ATTR_DIR    = attr-$(PYTHON_ATTR_VER)
PYTHON_ATTR_SOURCE = attr-$(PYTHON_ATTR_VER).tar.gz
PYTHON_ATTR_URL    = https://pypi.python.org/packages/source/a/attr

$(D)/python-attr: bootstrap python python-setuptools
	$(START_BUILD)
	$(call DOWNLOAD,$(PKG_SOURCE))
	$(REMOVE)/$(PKG_DIR)
	$(UNTAR)/$(PKG_SOURCE)
	$(CHDIR)/$(PKG_DIR); \
		$(PYTHON_BUILD); \
		$(PYTHON_INSTALL)
	$(REMOVE)/$(PKG_DIR)
	$(TOUCH)

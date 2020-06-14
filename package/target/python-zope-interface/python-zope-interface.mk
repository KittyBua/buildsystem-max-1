#
# python-zope-interface
#
PYTHON_ZOPE_INTERFACE_VER    = 4.5.0
PYTHON_ZOPE_INTERFACE_DIR    = zope.interface-$(PYTHON_ZOPE_INTERFACE_VER)
PYTHON_ZOPE_INTERFACE_SOURCE = zope.interface-$(PYTHON_ZOPE_INTERFACE_VER).tar.gz
PYTHON_ZOPE_INTERFACE_URL    = https://pypi.python.org/packages/source/z/zope.interface

$(D)/python-zope-interface: bootstrap python python-setuptools
	$(START_BUILD)
	$(call DOWNLOAD,$(PKG_SOURCE))
	$(REMOVE)/$(PKG_DIR)
	$(UNTAR)/$(PKG_SOURCE)
	$(CHDIR)/$(PKG_DIR); \
		$(PYTHON_BUILD); \
		$(PYTHON_INSTALL)
	$(REMOVE)/$(PKG_DIR)
	$(TOUCH)

#
# python-zope-interface
#
PYTHON_ZOPE_INTERFACE_VER    = 4.5.0
PYTHON_ZOPE_INTERFACE_DIR    = zope.interface-$(PYTHON_ZOPE_INTERFACE_VER)
PYTHON_ZOPE_INTERFACE_SOURCE = zope.interface-$(PYTHON_ZOPE_INTERFACE_VER).tar.gz
PYTHON_ZOPE_INTERFACE_SITE   = https://pypi.python.org/packages/source/z/zope.interface

$(D)/python-zope-interface: bootstrap python python-setuptools
	$(START_BUILD)
	$(PKG_REMOVE)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(call PKG_UNPACK,$(BUILD_DIR))
	$(PKG_APPLY_PATCHES)
	$(PKG_CHDIR); \
		$(PYTHON_BUILD); \
		$(PYTHON_INSTALL)
	$(PKG_REMOVE)
	$(TOUCH)

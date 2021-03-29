#
# python-zope-interface
#
PYTHON_ZOPE_INTERFACE_VERSION = 4.5.0
PYTHON_ZOPE_INTERFACE_DIR     = zope.interface-$(PYTHON_ZOPE_INTERFACE_VERSION)
PYTHON_ZOPE_INTERFACE_SOURCE  = zope.interface-$(PYTHON_ZOPE_INTERFACE_VERSION).tar.gz
PYTHON_ZOPE_INTERFACE_SITE    = https://pypi.python.org/packages/source/z/zope.interface
PYTHON_ZOPE_INTERFACE_DEPENDS = bootstrap python python-setuptools

python-zope-interface:
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

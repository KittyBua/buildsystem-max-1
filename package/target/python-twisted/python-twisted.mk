#
# python-twisted
#
PYTHON_TWISTED_VER    = 18.4.0
PYTHON_TWISTED_DIR    = Twisted-$(PYTHON_TWISTED_VER)
PYTHON_TWISTED_SOURCE = Twisted-$(PYTHON_TWISTED_VER).tar.bz2
PYTHON_TWISTED_SITE   = https://pypi.python.org/packages/source/T/Twisted

PYTHON_TWISTED_PATCH  = \
	0001-fix-writing-after-channel-is-closed.patch

$(D)/python-twisted: bootstrap python python-setuptools python-zope-interface python-constantly python-incremental python-pyopenssl python-service-identity
	$(START_BUILD)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(PKG_REMOVE)
	$(call PKG_UNPACK,$(BUILD_DIR))
	$(PKG_CHDIR); \
		$(call apply_patches, $(PKG_PATCH)); \
		$(PYTHON_BUILD); \
		$(PYTHON_INSTALL)
	$(PKG_REMOVE)
	$(TOUCH)

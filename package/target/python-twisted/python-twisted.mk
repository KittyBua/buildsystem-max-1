#
# python-twisted
#
PYTHON_TWISTED_VER    = 18.4.0
PYTHON_TWISTED_DIR    = Twisted-$(PYTHON_TWISTED_VER)
PYTHON_TWISTED_SOURCE = Twisted-$(PYTHON_TWISTED_VER).tar.bz2
PYTHON_TWISTED_SITE   = https://pypi.python.org/packages/source/T/Twisted
PYTHON_TWISTED_DEPS   = bootstrap python python-setuptools python-zope-interface python-constantly python-incremental python-pyopenssl python-service-identity

$(D)/python-twisted:
	$(START_BUILD)
	$(REMOVE)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(call EXTRACT,$(BUILD_DIR))
	$(PKG_APPLY_PATCHES)
	$(PKG_CHDIR); \
		$(PYTHON_BUILD); \
		$(PYTHON_INSTALL)
	$(REMOVE)
	$(TOUCH)

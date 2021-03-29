#
# python-twisted
#
PYTHON_TWISTED_VERSION = 18.4.0
PYTHON_TWISTED_DIR     = Twisted-$(PYTHON_TWISTED_VERSION)
PYTHON_TWISTED_SOURCE  = Twisted-$(PYTHON_TWISTED_VERSION).tar.bz2
PYTHON_TWISTED_SITE    = https://pypi.python.org/packages/source/T/Twisted
PYTHON_TWISTED_DEPENDS = bootstrap python python-setuptools python-zope-interface python-constantly python-incremental python-pyopenssl python-service-identity

python-twisted:
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

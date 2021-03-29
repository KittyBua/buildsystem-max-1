#
# python-setuptools
#
PYTHON_SETUPTOOLS_VERSION = 5.2
PYTHON_SETUPTOOLS_DIR     = setuptools-$(PYTHON_SETUPTOOLS_VERSION)
PYTHON_SETUPTOOLS_SOURCE  = setuptools-$(PYTHON_SETUPTOOLS_VERSION).tar.gz
PYTHON_SETUPTOOLS_SITE    = https://pypi.python.org/packages/source/s/setuptools
PYTHON_SETUPTOOLS_DEPENDS = bootstrap python

python-setuptools:
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

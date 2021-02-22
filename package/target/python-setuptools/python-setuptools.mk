#
# python-setuptools
#
PYTHON_SETUPTOOLS_VER    = 5.2
PYTHON_SETUPTOOLS_DIR    = setuptools-$(PYTHON_SETUPTOOLS_VER)
PYTHON_SETUPTOOLS_SOURCE = setuptools-$(PYTHON_SETUPTOOLS_VER).tar.gz
PYTHON_SETUPTOOLS_SITE   = https://pypi.python.org/packages/source/s/setuptools
PYTHON_SETUPTOOLS_DEPS   = bootstrap python

$(D)/python-setuptools:
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

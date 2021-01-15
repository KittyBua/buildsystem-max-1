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
	$(PKG_REMOVE)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(call PKG_UNPACK,$(BUILD_DIR))
	$(PKG_APPLY_PATCHES)
	$(PKG_CHDIR); \
		$(PYTHON_BUILD); \
		$(PYTHON_INSTALL)
	$(PKG_REMOVE)
	$(TOUCH)

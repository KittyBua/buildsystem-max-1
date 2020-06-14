#
# python-setuptools
#
PYTHON_SETUPTOOLS_VER    = 5.2
PYTHON_SETUPTOOLS_DIR    = setuptools-$(PYTHON_SETUPTOOLS_VER)
PYTHON_SETUPTOOLS_SOURCE = setuptools-$(PYTHON_SETUPTOOLS_VER).tar.gz
PYTHON_SETUPTOOLS_URL    = https://pypi.python.org/packages/source/s/setuptools

$(D)/python-setuptools: bootstrap python
	$(START_BUILD)
	$(call DOWNLOAD,$(PKG_SOURCE))
	$(REMOVE)/$(PKG_DIR)
	$(UNTAR)/$(PKG_SOURCE)
	$(CHDIR)/$(PKG_DIR); \
		$(PYTHON_BUILD); \
		$(PYTHON_INSTALL)
	$(REMOVE)/$(PKG_DIR)
	$(TOUCH)

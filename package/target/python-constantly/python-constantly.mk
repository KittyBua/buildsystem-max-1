#
# python-constantly
#
PYTHON_CONSTANTLY_VER    = 15.1.0
PYTHON_CONSTANTLY_DIR    = constantly-$(PYTHON_CONSTANTLY_VER)
PYTHON_CONSTANTLY_SOURCE = constantly-$(PYTHON_CONSTANTLY_VER).tar.gz
PYTHON_CONSTANTLY_SITE   = https://files.pythonhosted.org/packages/source/c/constantly

$(D)/python-constantly: bootstrap python python-setuptools
	$(START_BUILD)
	$(PKG_REMOVE)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(call PKG_UNPACK,$(BUILD_DIR))
	$(PKG_CHDIR); \
		$(PYTHON_BUILD); \
		$(PYTHON_INSTALL)
	$(PKG_REMOVE)
	$(TOUCH)

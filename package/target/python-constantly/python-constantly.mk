#
# python-constantly
#
PYTHON_CONSTANTLY_VER    = 15.1.0
PYTHON_CONSTANTLY_DIR    = constantly-$(PYTHON_CONSTANTLY_VER)
PYTHON_CONSTANTLY_SOURCE = constantly-$(PYTHON_CONSTANTLY_VER).tar.gz
PYTHON_CONSTANTLY_URL    = https://files.pythonhosted.org/packages/source/c/constantly

$(D)/python-constantly: bootstrap python python-setuptools
	$(START_BUILD)
	$(call DOWNLOAD,$(PKG_SOURCE))
	$(REMOVE)/$(PKG_DIR)
	$(UNTAR)/$(PKG_SOURCE)
	$(CHDIR)/$(PKG_DIR); \
		$(PYTHON_BUILD); \
		$(PYTHON_INSTALL)
	$(REMOVE)/$(PKG_DIR)
	$(TOUCH)

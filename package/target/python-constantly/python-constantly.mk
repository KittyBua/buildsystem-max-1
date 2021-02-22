#
# python-constantly
#
PYTHON_CONSTANTLY_VER    = 15.1.0
PYTHON_CONSTANTLY_DIR    = constantly-$(PYTHON_CONSTANTLY_VER)
PYTHON_CONSTANTLY_SOURCE = constantly-$(PYTHON_CONSTANTLY_VER).tar.gz
PYTHON_CONSTANTLY_SITE   = https://files.pythonhosted.org/packages/source/c/constantly
PYTHON_CONSTANTLY_DEPS   = bootstrap python python-setuptools

$(D)/python-constantly:
	$(START_BUILD)
	$(REMOVE)
	$(call DOWNLOAD,$($(PKG)_SOURCE))
	$(call EXTRACT,$(BUILD_DIR))
	$(APPLY_PATCHES)
	$(PKG_CHDIR); \
		$(PYTHON_BUILD); \
		$(PYTHON_INSTALL)
	$(REMOVE)
	$(TOUCH)

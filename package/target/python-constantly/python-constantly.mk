#
# python-constantly
#
PYTHON_CONSTANTLY_VERSION = 15.1.0
PYTHON_CONSTANTLY_DIR     = constantly-$(PYTHON_CONSTANTLY_VERSION)
PYTHON_CONSTANTLY_SOURCE  = constantly-$(PYTHON_CONSTANTLY_VERSION).tar.gz
PYTHON_CONSTANTLY_SITE    = https://files.pythonhosted.org/packages/source/c/constantly
PYTHON_CONSTANTLY_DEPENDS = bootstrap python python-setuptools

python-constantly:
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
